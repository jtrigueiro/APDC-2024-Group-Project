import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final LatLng restaurantLocation;

  MapScreen({required this.restaurantLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Set<Polyline> polylines = {};
  String googleApiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';
  String travelMode = 'driving';
  double totalDistance = 0.0;
  List<String> directions = [];

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
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
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newLatLng(_currentPosition));

    _getPolyline();
  }

  Future<void> _getPolyline() async {
    totalDistance = 0.0;
    directions.clear();  // Clear previous directions

    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=${widget.restaurantLocation.latitude},${widget.restaurantLocation.longitude}&mode=$travelMode&key=$googleApiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'].isNotEmpty) {
        setState(() {
          polylineCoordinates.clear();
          polylines.clear();
          polylineCoordinates.addAll(_decodePolyline(data['routes'][0]['overview_polyline']['points']));
          totalDistance = _calculateTotalDistance(polylineCoordinates);
          polylines.add(Polyline(
            width: 5,
            polylineId: const PolylineId('polyline'),
            color: Colors.blue,
            points: polylineCoordinates,
          ));

          // Store the directions and remove HTML tags
          directions.addAll(
              data['routes'][0]['legs'][0]['steps']
                  .map<String>((step) => _removeHtmlTags(step['html_instructions'].toString()))
                  .toList()
          );
        });
      } else {
        print('No routes found');
      }
    } else {
      print('Failed to fetch route');
    }
  }

  String _removeHtmlTags(String htmlString) {
    final regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(regExp, '');
  }

  double _calculateTotalDistance(List<LatLng> coordinates) {
    double distance = 0.0;
    for (int i = 0; i < coordinates.length - 1; i++) {
      distance += _coordinateDistance(
        coordinates[i].latitude,
        coordinates[i].longitude,
        coordinates[i + 1].latitude,
        coordinates[i + 1].longitude,
      );
    }
    return distance;
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = (double x) => cos(x);
    var a = 0.5 - c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: Column(
        children: [
          Container(
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(
                    'Km: ${totalDistance.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                _buildTravelModeButton('driving', Icons.directions_car),
                _buildTravelModeButton('walking', Icons.directions_walk),
                _buildTravelModeButton('transit', Icons.directions_transit),
              ],
            ),
          ),
          Expanded(
            child: _currentPosition.latitude == 0 && _currentPosition.longitude == 0
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: [
                Expanded(
                  flex: 4,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: widget.restaurantLocation,
                      zoom: 14.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: _currentPosition,
                        infoWindow: InfoWindow(title: 'Your Location'),
                      ),
                      Marker(
                        markerId: MarkerId('restaurantLocation'),
                        position: widget.restaurantLocation,
                        infoWindow: InfoWindow(title: 'Restaurant'),
                      ),
                    },
                    polylines: polylines,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: directions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(directions[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelModeButton(String mode, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          travelMode = mode;
          _getPolyline();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: travelMode == mode ? Colors.blue : Colors.grey,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
