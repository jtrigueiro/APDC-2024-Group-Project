import 'dart:async';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/firebase_storage.dart';
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
  bool fetchingLocations = true;
  bool paddingNeeded = false;
  bool choosingDate = true;
  String? _mapStyle;
  double _markerFont = kIsWeb ? 12 : 80;
  DateTime? _selectedDate;
  List<String> locations = [];

  @override
  void initState() {
    super.initState();
    currentLocation = widget.userLocation;
    getLocations();
    _loadMapStyle();
  }

  void getLocations() async {
    try {
      locations = await DatabaseService().getLocations();
    } catch (e) {
      print('error fetching locations');
    }
    setState(() {
      fetchingLocations = false;
    });
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

  void _getDateFromUser() async {
    _selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 14)),
    cancelText: 'Ignore',
    confirmText: 'OK',
    helpText: 'Reservation Date',
    errorFormatText: 'Invalid date format',
    errorInvalidText: 'Date must be within the next 14 days',
    fieldLabelText: 'Reservation Date',
    fieldHintText: 'Month/Day/Year',
    );

    if (_selectedDate != null) {
      enhanceResult();
      setState(() {
      });
    }
  }

  void enhanceResult() {
    int weekday = _selectedDate!.weekday;

    final values = restaurants.where((element) => element.isOpen[weekday - 1]).toList();

    if(values.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No restaurants available'),
            content: const Text('There are no restaurants available on the selected date.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },);
    }
    else {
      restaurants.clear();
      markers.clear();

      for (int i = 0; i < values.length; i++) {
        handleRestaurant(values[i], i);
      }
    }
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
      body:  Column (
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('Please select a location to continue.'),
          ),
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
          fetchingLocations ? const LoadingScreen() : Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
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
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(Icons.restaurant),
            ),
            Text('Restaurants  •  $currentLocality'),
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
          height: MediaQuery.of(context).size.height*0.15,
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

  InkWell restaurantTile(BuildContext context, Restaurant restaurant) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantScreen(info: restaurant, day: null),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10),
      child: Container(
        //width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            FutureBuilder(
              future: null,
              builder: (context, snapshot) {
                return Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.width*0.2,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/restaurant_1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
                /*
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    height: MediaQuery.of(context).size.width*0.2,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                      image: NetworkImage(snapshot.data as String),
                      fit: BoxFit.cover,
                      ),
                    ),
                  );
                }*/
              }
            ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 5),
                    child: Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  textLine('4.5', Icons.star ,context, Colors.amber),
                  textLine('10.1 kg/yr CO2', Icons.eco,context,Colors.green),
                  textLine('1.2 km', Icons.location_on,context, Colors.grey),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}
Future<String> getRestaurantImageURL(String id) async {
  String url = await StorageService().getRestaurantImageUrl(id);
  return url;
}
}


Row textLine(String text, IconData icon, BuildContext context, Color color) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Icon(icon, size: 17, color: color),
      ),
      Text(text, style: Theme.of(context).textTheme.bodyMedium,),
    ],
  );
}