import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  List<Marker> markers = [];
  DetailsResult? selectedPlace;
  bool isAddingMarker = false;
  TextEditingController locationController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? _mapStyle;

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

  Future<String?> _getAddressFromLatLng(LatLng position) async {
    const String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug'; // Replace with your actual API key
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'OK') {
        return json['results'][0]['formatted_address'];
      } else {
        print('Error: ${json['status']}');
        return null;
      }
    } else {
      print('Failed to fetch address');
      return null;
    }
  }

  Future<void> _handleTap(LatLng point) async {
    if (!isAddingMarker) return;

    setState(() {
      isAddingMarker = false;
    });

    String? address = await _getAddressFromLatLng(point);

    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Restaurant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(hintText: 'Phone'),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'save');
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == 'save') {
      setState(() {
        Marker newMarker = Marker(
          markerId: MarkerId(point.toString()),
          position: point,
          infoWindow: InfoWindow(
            title: nameController.text,
            snippet: 'Address: $address<br>Rating: 0<br>Phone: ${phoneController.text}',
          ),
          onTap: () {
            _showPlaceDetails(
              nameController.text,
              address ?? 'No Address',
              '0',
              phoneController.text,
            );
          },
        );
        markers.add(newMarker);
        _showPlaceDetails(
          nameController.text,
          address ?? 'No Address',
          '0',
          phoneController.text,
        );
      });
    }
  }

  void _showPlaceDetails(String name, String address, String rating, String phone) {
    setState(() {
      selectedPlace = DetailsResult(
        name: name,
        formattedAddress: address,
        rating: double.tryParse(rating),
        formattedPhoneNumber: phone,
      );
    });
  }

  Future<void> _moveToLocation(String location) async {
    const String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug'; // Replace with your actual API key
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$location&key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'OK') {
        final location = json['results'][0]['geometry']['location'];
        final LatLng target = LatLng(location['lat'], location['lng']);

        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLng(target));
      } else {
        print('Error: ${json['status']}');
      }
    } else {
      print('Failed to fetch location');
    }
  }

  Future<void> _searchForRestaurants(String query) async {
    List<Marker> matchingMarkers = markers.where((marker) => marker.infoWindow.title?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();

    if (matchingMarkers.isNotEmpty) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newLatLng(matchingMarkers.first.position));

      setState(() {
        selectedPlace = DetailsResult(
          name: matchingMarkers.first.infoWindow.title,
          formattedAddress: matchingMarkers.first.infoWindow.snippet?.split('\n').firstWhere((element) => element.startsWith('Address: '), orElse: () => 'Address: No Address').substring(9),
          rating: double.tryParse(matchingMarkers.first.infoWindow.snippet?.split('\n').firstWhere((element) => element.startsWith('Rating: '), orElse: () => 'Rating: No Rating').substring(8) ?? '0'),
          formattedPhoneNumber: matchingMarkers.first.infoWindow.snippet?.split('\n').firstWhere((element) => element.startsWith('Phone: '), orElse: () => 'Phone: No Phone').substring(7),
        );
      });
    } else {
      setState(() {
        selectedPlace = null;
      });
    }
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

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 7.7),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 10.8,
                            height: 21.6,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: 10.8,
                                height: 21.6,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_34_x2.svg',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Add Restaurant',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF34A853),
                            ),
                          ),
                          Switch(
                            value: isAddingMarker,
                            onChanged: (value) {
                              setState(() {
                                isAddingMarker = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5.7, 0, 0, 40.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 23),
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFA8A6A7)),
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFFFFFFF),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(0, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16.3, 10, 19.6, 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                  child: SizedBox(
                                    width: 253.7,
                                    child: TextField(
                                      controller: locationController,
                                      decoration: const InputDecoration(
                                        hintText: 'Location',
                                        hintStyle: TextStyle(color: Colors.grey), // Set the color to a visible shade
                                        border: InputBorder.none,
                                      ),
                                      style: GoogleFonts.getFont(
                                        'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: const Color(0xFF34A853),
                                      ),
                                      onSubmitted: (value) {
                                        _moveToLocation(value);
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                  child: GestureDetector(
                                    onTap: () {
                                      _moveToLocation(locationController.text);
                                    },
                                    child: SizedBox(
                                      width: 16.4,
                                      height: 20,
                                      child: SvgPicture.asset(
                                        'assets/vectors/iconmap_pin_1_x2.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFA8A6A7)),
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xFFFFFFFF),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                offset: Offset(0, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(16, 10, 17, 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
                                  child: SizedBox(
                                    width: 253,
                                    child: TextField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        hintText: 'Search for Restaurants',
                                        hintStyle: TextStyle(color: Colors.grey), // Set the color to a visible shade
                                        border: InputBorder.none,
                                      ),
                                      style: GoogleFonts.getFont(
                                        'Nunito',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: const Color(0xFF34A853),
                                      ),
                                      onSubmitted: (value) {
                                        _searchForRestaurants(value);
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                  child: GestureDetector(
                                    onTap: () {
                                      _searchForRestaurants(searchController.text);
                                    },
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: SvgPicture.asset(
                                        'assets/vectors/search_icon_1_x2.svg',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                    onTap: _handleTap,
                    markers: Set<Marker>.of(markers),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: _centerOnUserLocation,
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10.2, 20, 8.6, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0.9, 24.5),
                      child: Text(
                        'Restaurant',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF34A853),
                        ),
                      ),
                    ),
                    if (selectedPlace != null) ...[
                      Text(
                        selectedPlace!.name ?? "No Name",
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: const Color(0xFF34A853),
                        ),
                      ),
                      Text("Address: ${selectedPlace!.formattedAddress ?? "No Address"}"),
                      Text("Rating: ${selectedPlace!.rating?.toString() ?? "No Rating"}"),
                      Text("Phone: ${selectedPlace!.formattedPhoneNumber ?? "No Phone"}"),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsResult {
  final String? name;
  final String? formattedAddress;
  final double? rating;
  final String? formattedPhoneNumber;

  DetailsResult({this.name, this.formattedAddress, this.rating, this.formattedPhoneNumber});
}
