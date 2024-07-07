import 'dart:async';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/geocoding.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class SearchScreen extends StatefulWidget {
  final LatLng userLocation;

  const SearchScreen({ Key? key, required this.userLocation }): super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<Restaurant> restaurants = [];
  Set<Marker> markers = {};

  final TextEditingController locationController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final CarouselController carouselController = CarouselController();

  final IconData locationIcon = const IconData(0xf193, fontFamily: 'MaterialIcons');
  final IconData searchIcon = const IconData(0xf013d, fontFamily: 'MaterialIcons');

  late LatLng currentLocation;
  String currentLocality = '';
  bool done = false;
  bool paddingNeeded = false;
  bool choosingDate = true;
  String? _mapStyle;
  double _markerFont = kIsWeb ? 12 : 80;
  DateTime? _selectedDate;
  List<String> locations = [];

  @override
  void initState() async {
    super.initState();
    locations = await DatabaseService().getLocations();
    _loadMapStyle();
  }

  Future<int> getCityByCoords(LatLng coordinates) async {
      return GeocodingService().reverseGeocode(coordinates.latitude, coordinates.longitude).then((value) {
          if (value['status'] == 'OK') {
              final int size = value['results'][0]['address_components'].length;
              final city = value['results'][0]['address_components'][size - 4]['long_name'];
  
              setState(() {
                  currentLocality = city;
                  locationController.text = city;
              });
  
              return 1;
          }
          return 0;
      });
  }

  void getCityByAddress(String address) {
    GeocodingService().geocode(address).then((value) {
      if (value['status'] == 'OK') {
          final int size = value['results'][0]['address_components'].length;
          final String city = value['results'][0]['address_components'][size - 4]['long_name'];
          locationController.text = city;
          currentLocality = city;
          currentLocation = LatLng(value['results'][0]['geometry']['location']['lat'],
            value['results'][0]['geometry']['location']['lng']);
        }
      });
    }

  Future<void> _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString('assets/map_style.json');
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (_mapStyle != null) {
      controller.setMapStyle(_mapStyle);
    }
  }

  void _handleTap(LatLng point) {
    print(point);
  }

  void cameraMoved(CameraPosition position) {
    setState(() {
      _markerFont = calculateMarkerSize(position.zoom);
    });
  }

  double calculateMarkerSize(double zoom) {
    if (zoom <= 10) {
      return kIsWeb ? 14.0 : 80.0;
    } else if (zoom <= 15) {
      return kIsWeb ? 13.0 : 60.0;
    } else {
      return kIsWeb ? 12.0 : 40.0;
    }
  }

  void handleRestaurant(Restaurant restaurant, int index) {
    List<String> coords = restaurant.coordinates.split(',');

    restaurants.add(restaurant);
    LatLng pos = LatLng(double.parse(coords[0]), double.parse(coords[1]));

    markers.addLabelMarker(LabelMarker(
      textStyle: TextStyle(color: Colors.white, fontSize: _markerFont),
    onTap: () {
      carouselController.animateToPage(index);
    },
    label: restaurant.name,
    markerId: MarkerId(index.toString()),
    position: pos,),
    ).then((_) {
     setState(() {});
    });
  }


  void getRestaurants(String location) async {
      restaurants.clear();
      markers.clear();

      final DatabaseService db = DatabaseService();
      final values = await db.getRestaurantsbyLocation(location.toLowerCase());

      for (int i = 0; i < values.length; i++) {
        handleRestaurant(values[i], i);
      }

      if(values.isNotEmpty) {
        changeCamera(0);
      }

      setState(() {
        done = true;
        paddingNeeded = values.isEmpty ? false : true;
      });

  }

  

  Future<void> _moveToLocation(String location) async {
    GeocodingService().geocode(location).then((value) async {
      if (value['status'] == 'OK') {
        final LatLng target = LatLng(value['results'][0]['geometry']['location']['lat'],
          value['results'][0]['geometry']['location']['lng']);

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(target, 13.0));
        getRestaurants(location.toLowerCase());

      } else {
        print('Error: ${value['status']}');
      }
    });
  }

  void _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2030));

  if (_pickerDate != null) {
    setState(() {
      _selectedDate = _pickerDate;
    });
}
 }

  Future showDateBox(BuildContext context) {
    return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Date Selection'),
        content: const Text('Please select a date to continue.'),
        actions: [
          DatePickerDialog(firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 7)),
            initialDate: DateTime.now(),
            ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    choosingDate = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Ignore'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    choosingDate = false;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ]),
        ],
      );
    },);
  }

  Future<void> _searchForRestaurants(String query) async {
    restaurants.clear();
    markers.clear();

    final databaseService = DatabaseService();
    final values = await databaseService.searchRestaurants(query);

    for (int i = 0; i < values.length; i++) {
      handleRestaurant(values[i], i);
    }

    setState(() {
      done = true;
      paddingNeeded = values.isEmpty ? false : true;
    });
  }

  Future<void> _centerOnUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  }

  void changeCamera(int index) async {
    List<String> coords = restaurants[index].coordinates.split(',');

    double lat = double.parse(coords[0]);
    double lng = double.parse(coords[1]);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(lat, lng)));

    setState(() {
      currentLocation = LatLng(lat, lng);
    });
  }

  Row searchBox(String label, IconData icon, Function function,
    TextEditingController controller, bool location) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              location ? setState(() {
                choosingDate = true;
              }) :
              function(controller.text);
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child: Icon(icon, size: 20, color: const Color(0xFF000000)),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 11, 0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onSubmitted: (value) {
                function(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Scaffold locationScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Please select a location to continue.'),
          const SizedBox(height: 20),
          ListTile(
                title: const Text('Current Location'),
                leading: const Icon(Icons.my_location),
                onTap: () {
                  setState(() async {
                    currentLocation = widget.userLocation;
                    getCityByCoords(currentLocation).then((value) { getRestaurants(currentLocality); });
                    choosingDate = false;
                  });
                },
              ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                List<String> locations = ['Cascais', 'Lisboa', 'Porto', 'Almada', 'Amadora'];
                return ListTile(
                  title: Text(locations[index]),
                  leading: const Icon(Icons.location_on),
                  onTap: () {
                    setState(() async {
                      getCityByAddress(locations[index]);
                      getRestaurants(locations[index]);
                      choosingDate = false;
                    });
                  },
                );
              },
          ),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return choosingDate ? locationScreen(context) : Scaffold (
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            const Icon(Icons.restaurant),
            const SizedBox(width: 20),
            Text('Restaurants   •   $currentLocality'),
          ],
        ),
      ),
      body: Center(
        child:  Column(
          children: [
            searchBox('Search for restaurants', searchIcon,
                    _searchForRestaurants, searchController, false),
            Expanded(
              child: Stack(
                children: [
                  done ? GoogleMap(
                    padding: paddingNeeded ? const EdgeInsets.only(bottom: 100) : EdgeInsets.zero,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    markers: markers,
                    onCameraMove: cameraMoved,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 13.0,
                    ),
                    onTap: _handleTap,
                  ) : const LoadingScreen(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: paddingNeeded ? carouselSlider(carouselController, restaurants) : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider carouselSlider(CarouselController carouselController, List<Restaurant> info) {
      return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          height: 100,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          onScrolled: (index) => changeCamera(index!.toInt()),
        ),
        items: info.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return restaurantTile(context, item);
            },
          );
        }).toList(),
    );
  }
}

InkWell restaurantTile(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantScreen(info: restaurant),
        ),
      );
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              /*
              image: DecorationImage(
              image: NetworkImage(item.imageUrl),
              fit: BoxFit.cover,
              ),*/
              image: const DecorationImage(
                image: AssetImage('assets/images/restaurant_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox( height: 5,),
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                textLine('4.5', const Icon(Icons.star, color: Colors.amber, size: 16,)),
                textLine('10.1 kg/yr CO2', const Icon(Icons.eco, size: 16, color: Colors.grey)),
                textLine('1.2 km', const Icon(Icons.location_on, size: 16, color: Colors.grey)),
              ],
            ),
        ],
      ),
    ),
  );
}

Row textLine(String text, Icon icon) {
  return Row(
    children: [
      icon,
      const SizedBox(width: 5),
      Text(text),
    ],
  );
}

Widget restaurantMarkers(List<Restaurant> info) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: info.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(info[index].name),
        subtitle: Text(info[index].location),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantScreen(
                info: info[index],
              ),
            ),
          );
        },
        selectedColor: const Color(0xFFf2f2f2),
        selected: true,
      );
    },
  );

  
}