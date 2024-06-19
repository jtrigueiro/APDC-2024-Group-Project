import 'dart:async';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final LatLng _center = const LatLng(38.660259532890706, -9.203190255573041);

  final String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';

  List<Map<String, String>> restaurants = [];

  TextEditingController locationController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? _mapStyle;

  final IconData locationIcon = const IconData(0xf193, fontFamily: 'MaterialIcons');
  final IconData searchIcon = const IconData(0xf013d, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
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

  bool inRadius(LatLng point, LatLng center, double radius) {
    return Geolocator.distanceBetween(
            point.latitude, point.longitude, center.latitude, center.longitude) <
        radius;
  }

  void addRestaurant(Map<String, dynamic> restaurant) {
    restaurants.add({
            'image': restaurant['image'],
            'name' : restaurant['name'],
            'address' : restaurant['address'],
            'rating' : restaurant['rating'],
            'phone' : restaurant['phone'],
          });
  }

  void getRestaurants(String location) {
    restaurants.clear();
    final DatabaseService db = DatabaseService();
    final data = db.getRestaurantsbyLocation(location);

    data.then((values) {
      for(var restaurant in values) {
        final LatLng position = LatLng(restaurant['latitude'], restaurant['longitude']);

        if(inRadius(position, _center, 5000)) {
          addRestaurant(restaurant);
        }
      }
    });
  }

  Future<void> _moveToLocation(String location) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$location&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'OK') {
        final location = json['results'][0]['geometry']['location'];
        final LatLng target = LatLng(location['lat'], location['lng']);

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(target));

        getRestaurants(location.toString());

      } else {
        print('Error: ${json['status']}');
      }
    } else {
      print('Failed to fetch location');
    }
  }

  Future<void> _searchForRestaurants(String query) async {
    final databaseService = DatabaseService();
    databaseService.searchRestaurants(query).then((values) {
      restaurants.clear();
      for (var restaurant in values) {
        final LatLng position = LatLng(restaurant['latitude'], restaurant['longitude']);
  
        if (inRadius(position, _center, 5000)) {
          addRestaurant(restaurant);
        }
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color:Color.fromARGB(255, 117, 85, 18)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
              children: [
                searchBox('Location', locationIcon, _moveToLocation, locationController).widget!,
                FloatingActionButton(
                  mini: true,
                  onPressed: _centerOnUserLocation,
                  child: const Icon(Icons.my_location),
                ),
              ],
            ),
      ),

      body: Center(
        child: Column(
          children: [
            searchBox('Search for restaurants', searchIcon, _searchForRestaurants, searchController).widget!,
            
            Expanded(
              child: Stack(
                children: [
                    Positioned.fill(
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 14.0,
                        ),
                        onTap: _handleTap,
                      ),
                    ),
                    restaurantMarkers(restaurants),
                ],
              ),
            ),
        ],)
      ),
    );
  }

}

ListView restaurantMarkers(List<Map<String, String>> info) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: info.length,
    itemBuilder: (context, index) {
      return ListTile(
        leading: Image.asset(info[index]['image']!),
        title: Text(info[index]['name']!),
        subtitle: Text(info[index]['address']!),
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
      );
    },
  );
}

SearchBox searchBox(String label, IconData icon, Function function, TextEditingController controller) {
  return SearchBox(
    widget: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              function(controller.text);
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child: Icon(icon, size: 20, color: const Color(0xFF000000))
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 11, 0),
          child: SizedBox(
            width: 250,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: label,
                hintStyle: const TextStyle(
                    color: Colors.grey),
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
    ),
  );

}

class SearchBox {
  final Widget? widget;

  SearchBox({this.widget});
}
