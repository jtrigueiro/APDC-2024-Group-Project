import 'dart:async';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  final LatLng userLocation;

  const SearchScreen({ Key? key, required this.userLocation }): super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';

  List<Map<String, String>> restaurants = [];
  List<Marker> markers = [];

  final TextEditingController locationController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  final IconData locationIcon = const IconData(0xf193, fontFamily: 'MaterialIcons');
  final IconData searchIcon = const IconData(0xf013d, fontFamily: 'MaterialIcons');

  late LatLng currentLocation;
  String currentLocality = '';
  bool done = false;
  String? _mapStyle;

  @override
  void initState() {
    currentLocation = widget.userLocation;
    getLocality(currentLocation);
    _loadMapStyle();
    getRestaurants(currentLocality);
    super.initState();
  }

  void getLocality(LatLng coordinates) {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=$apiKey');
    http.get(url).then((response) {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final locality = json['results'][0]['address_components'][2]['long_name'];
          currentLocality = locality;
          locationController.text = locality;
        }
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

  void getCenter(String center) async {
        final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$center&key=$apiKey');
    final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final result = json['results'][0]['geometry']['location'];
          currentLocation = LatLng(result['lat'], result['lng']);
        }
        else {
          currentLocation = const LatLng(38.660259532890706, -9.203190255573041);
        }
      }
      else {
        currentLocation = const LatLng(38.660259532890706, -9.203190255573041);
      }
  }

  void _handleTap(LatLng point) {
    print(point);
  }

  bool inRadius(LatLng point, LatLng center, double radius) {
    return Geolocator.distanceBetween(point.latitude, point.longitude,
            center.latitude, center.longitude) <
        radius;
  }

  void handleRestaurant(Map<String, dynamic> restaurant, int index) {
    List<String> coords = restaurant['coordinates'].split(',');

    restaurants.add({
      'name': restaurant['name'],
      'address': restaurant['address'],
      'location': restaurant['location'],
      'phone': restaurant['phone'],
      'latitude': coords[0],
      'longitude': coords[1],
    });

    markers.add(
      Marker(
        markerId: MarkerId(index.toString()),
        position: LatLng(double.parse(coords[0]), double.parse(coords[1])),
        infoWindow: InfoWindow(
          title: restaurant['name'],
          snippet: restaurant['location'],
        ),
      ),
    );
  }

  void getRestaurants(String locality) async {
      restaurants.clear();
      markers.clear();

      final DatabaseService db = DatabaseService();
      final values = await db.getRestaurantsbyLocality(locality.toLowerCase());

      for (int i = 0; i < values.length; i++) {
        handleRestaurant(values[i], i);
      }

      setState(() {
        done = true;
      });
  }

  Future<void> _moveToLocation(String location) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$location&key=$apiKey');
    final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final result = json['results'][0]['geometry']['location'];
          final LatLng target = LatLng(result['lat'], result['lng']);

          //final GoogleMapController controller = await _controller.future;
          //controller.animateCamera(CameraUpdate.newLatLng(target));

          setState(() {
            currentLocation = target;
            done = false;
          });

          getRestaurants(location.toLowerCase());
        } else {
          print('Error: ${json['status']}');
        }
      } else {
        print('Failed to fetch location');
      }
      currentLocality = location;
  }

  Future<void> _searchForRestaurants(String query) async {
    final databaseService = DatabaseService();
    databaseService.searchRestaurants(query).then((values) {
      restaurants.clear();
      for (var restaurant in values) {
          handleRestaurant(restaurant, values.indexOf(restaurant));
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
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 117, 85, 18)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Expanded(
              child: searchBox("Location", locationIcon, _moveToLocation,
                      locationController)
                  .widget!,
            ),
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
            searchBox('Search for restaurants', searchIcon,
                    _searchForRestaurants, searchController)
                .widget!,
            Expanded(
              child: Stack(
                children: [
                   done ? GoogleMap(
                    markers: Set.of(markers),
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 14.0,
                    ),
                    onTap: _handleTap,
                  ) : const LoadingScreen(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: restaurantMarkers(restaurants),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget restaurantMarkers(List<Map<String, String>> info) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: info.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: Text(info[index]['name']!),
        subtitle: Text(info[index]['location']!),
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

SearchBox searchBox(String label, IconData icon, Function function,
    TextEditingController controller) {
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
    ),
  );
}

class SearchBox {
  final Widget? widget;

  SearchBox({this.widget});
}
