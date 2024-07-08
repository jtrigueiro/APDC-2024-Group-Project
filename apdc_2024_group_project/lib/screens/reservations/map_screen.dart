import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  StreamSubscription<Position>? _positionStreamSubscription;

  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Set<Polyline> polylines = {};
  String googleApiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';
  String travelMode = 'driving';
  double totalDistance = 0.0;

  List<Map<String, String>> _directions = [];
  int _currentDirectionIndex = 0;
  bool isModeLocked = false;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  void _startLocationUpdates() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
      _updateMapLocation();
      _getPolyline();
      _updateCurrentDirection();
    });
  }

  void _updateMapLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(_currentPosition),
    );
  }

  Future<void> _getPolyline() async {
    totalDistance = 0.0;
    if (travelMode == 'transit') {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=${widget.restaurantLocation.latitude},${widget.restaurantLocation.longitude}&mode=transit&key=$googleApiKey'));

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
            _directions = _extractDirections(data['routes'][0]['legs'][0]['steps']);
          });
        } else {
          print('No routes found');
        }
      } else {
        print('Failed to fetch transit route');
      }
    } else {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
          destination: PointLatLng(widget.restaurantLocation.latitude, widget.restaurantLocation.longitude),
          mode: travelMode == 'driving' ? TravelMode.driving : TravelMode.walking,
        ),
        googleApiKey: googleApiKey,
      );

      if (result.points.isNotEmpty) {
        setState(() {
          polylineCoordinates.clear();
          polylineCoordinates.addAll(result.points.map((point) => LatLng(point.latitude, point.longitude)));
          totalDistance = _calculateTotalDistance(polylineCoordinates);
          polylines.clear();
          polylines.add(Polyline(
            width: 5,
            polylineId: const PolylineId('polyline'),
            color: Colors.blue,
            points: polylineCoordinates,
          ));
        });

        final response = await http.get(Uri.parse(
            'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=${widget.restaurantLocation.latitude},${widget.restaurantLocation.longitude}&mode=$travelMode&key=$googleApiKey'));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['routes'].isNotEmpty) {
            setState(() {
              _directions = _extractDirections(data['routes'][0]['legs'][0]['steps']);
            });
          } else {
            print('No routes found');
          }
        } else {
          print('Failed to fetch route');
        }
      } else {
        print('Error: ${result.errorMessage}');
      }
    }
  }

  List<Map<String, String>> _extractDirections(List<dynamic> steps) {
    List<Map<String, String>> directions = [];
    for (var step in steps) {
      directions.add({
        'instruction': _removeHtmlTags(step['html_instructions']),
        'maneuver': step['maneuver'] ?? 'straight',
      });
    }
    return directions;
  }

  String _removeHtmlTags(String html) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return html.replaceAll(exp, '');
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

  void _updateCurrentDirection() {
    if (_directions.isEmpty) return;

    setState(() {
      if (_currentDirectionIndex < _directions.length - 1) {
        _currentDirectionIndex++;
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
  }

  void _showNavigationOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                title: Text('Open on Google Maps App'),
                onTap: () {
                  Navigator.pop(context);
                  _openGoogleMaps();
                },
              ),
              ListTile(
                title: Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openGoogleMaps() async {
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=${_currentPosition.latitude},${_currentPosition.longitude}&destination=${widget.restaurantLocation.latitude},${widget.restaurantLocation.longitude}&travelmode=$travelMode';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open the map.';
    }
  }

  IconData _getManeuverIcon(String maneuver) {
    switch (maneuver) {
      case 'turn-slight-left':
        return Icons.turn_slight_left;
      case 'turn-sharp-left':
        return Icons.turn_sharp_left;
      case 'uturn-left':
        return Icons.u_turn_left;
      case 'turn-left':
        return Icons.turn_left;
      case 'turn-slight-right':
        return Icons.turn_slight_right;
      case 'turn-sharp-right':
        return Icons.turn_sharp_right;
      case 'uturn-right':
        return Icons.u_turn_right;
      case 'turn-right':
        return Icons.turn_right;
      case 'straight':
        return Icons.straight;
      case 'roundabout-left':
        return Icons.roundabout_left;
      case 'roundabout-right':
        return Icons.roundabout_right;
      case 'fork-left':
        return Icons.call_split;
      case 'fork-right':
        return Icons.call_merge;
      case 'merge':
        return Icons.merge_type;
      case 'ramp-left':
        return Icons.call_split;
      case 'ramp-right':
        return Icons.call_merge;
      case 'keep-left':
        return Icons.arrow_left;
      case 'keep-right':
        return Icons.arrow_right;
      case 'crossing':
        return Icons.directions_walk;
      case 'ramp-straight':
        return Icons.straight;
      case 'ferry':
        return Icons.directions_boat;
      default:
        return Icons.directions;
    }
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
                _buildLockModeButton(),
                _buildConfirmDestinationButton(),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                NextDirectionBox(
                  nextDirection: _directions.isNotEmpty && _currentDirectionIndex < _directions.length
                      ? _directions[_currentDirectionIndex]['instruction']!
                      : 'No directions available',
                  directionIcon: _directions.isNotEmpty && _currentDirectionIndex < _directions.length
                      ? _getManeuverIcon(_directions[_currentDirectionIndex]['maneuver']!)
                      : Icons.straight,
                ),
                Expanded(
                  child: _currentPosition.latitude == 0 && _currentPosition.longitude == 0
                      ? Center(child: CircularProgressIndicator())
                      : GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: widget.restaurantLocation,
                      zoom: 14.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('currentLocation'),
                        position: _currentPosition,
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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
        if (!isModeLocked) {
          setState(() {
            travelMode = mode;
            _getPolyline();
          });
        }
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

  Widget _buildLockModeButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isModeLocked = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transit mode locked: $travelMode'),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildConfirmDestinationButton() {
    return GestureDetector(
      onTap: () {
        _showNavigationOptions();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.location_on,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class NextDirectionBox extends StatelessWidget {
  final String nextDirection;
  final IconData directionIcon;

  NextDirectionBox({required this.nextDirection, required this.directionIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(directionIcon, size: 30.0, color: Colors.blue),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              nextDirection,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
