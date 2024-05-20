import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<SearchScreen> {
  GoogleMapController? mapController;

  final LatLng _center = const LatLng(38.660259532890706, -9.203190255573041);

  // Variables to hold the details of the selected place
  String? selectedPlaceName;
  String? selectedPlaceAddress;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(18.3, 16.7, 19, 156),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 7.7),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 10.8,
                    height: 21.6,
                    child: SizedBox(
                      width: 10.8,
                      height: 21.6,
                      child: SvgPicture.network(
                        'assets/vectors/vector_34_x2.svg',
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5.7, 0, 0, 40.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 23),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFA8A6A7)),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16.3, 10, 19.6, 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 11, 0),
                              child: SizedBox(
                                width: 253.7,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Location',
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.getFont(
                                    'Nunito',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF34A853),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
                              child: SizedBox(
                                width: 16.4,
                                height: 20,
                                child: SvgPicture.network(
                                  'assets/vectors/iconmap_pin_1_x2.svg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFA8A6A7)),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 2),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16, 10, 17, 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 11, 0),
                              child: SizedBox(
                                width: 253,
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search for Restaurants',
                                    border: InputBorder.none,
                                  ),
                                  style: GoogleFonts.getFont(
                                    'Nunito',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Color(0xFF34A853),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 1, 0, 1),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.network(
                                  'assets/vectors/search_icon_1_x2.svg',
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
              Center( // Centering from here
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20), // Adjusted margin for better spacing
                  child: Text(
                    'Map',
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Color(0xFF34A853),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                  EdgeInsets.fromLTRB(10.2, 0, 8.6, 0),
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 14.0,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10.2, 20, 8.6, 0), // Adjusted margin for better spacing
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0.9, 24.5),
                        child: Text(
                          'Restaurants',
                          style: GoogleFonts.getFont(
                            'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xFF34A853),
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
      ),
    );
  }
}