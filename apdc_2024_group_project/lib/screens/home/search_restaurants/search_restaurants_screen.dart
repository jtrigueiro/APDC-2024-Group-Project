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

class SearchScreen extends StatefulWidget {
  final LatLng userLocation;
  final bool isSharingLocation;

  const SearchScreen({ Key? key, required this.userLocation, required this.isSharingLocation}): super(key: key);

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

  Future<String> getDistance(double originLatitude, double originLongitude, double destinationLatitude, double destinationLongitude) async {
    return await GeocodingService().getDistance(originLatitude, originLongitude, destinationLatitude, destinationLongitude).then((value) {
      if (value['status'] == 'OK') {
        print(value['rows'][0]['elements'][0]['distance']['text']);
        return value['rows'][0]['elements'][0]['distance']['text'];
      }
      return '';
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
          if(widget.isSharingLocation) {
            List<String> itemCoords = item.coordinates.split(',');
            return FutureBuilder(
              future: getDistance(widget.userLocation.latitude, widget.userLocation.longitude, double.parse(itemCoords[0]), double.parse(itemCoords[1])),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return restaurantTile(context, item, snapshot.data);
              },
            );
          } else {
            return Builder(
              builder: (BuildContext context) {
                return restaurantTile(context, item, null);
              },
            );
          }
        }).toList(),
    );
  }

  InkWell restaurantTile(BuildContext context, Restaurant restaurant, dynamic distance) {
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
      padding: const EdgeInsets.only(bottom: 4, left: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
              Container(
                  width: 100,
                  height: MediaQuery.of(context).size.width*0.2,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl,),
                      fit: BoxFit.cover,
                    ),
                  ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 5),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  textLine('N/A', Icons.star ,context, Colors.amber),
                  textLine('${restaurant.co2EmissionEstimate.toStringAsPrecision(5)} kg CO2 per year', Icons.eco,context,Colors.green),
                  distance != null ? textLine('$distance away', Icons.directions_walk, context, Colors.blue) : const SizedBox(),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}
}


Row textLine(String text, IconData icon, BuildContext context, Color color) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Icon(icon, size: 15, color: color),
      ),
      Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12),),
    ],
  );
}