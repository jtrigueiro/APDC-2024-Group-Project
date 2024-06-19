import 'dart:async';
import 'dart:convert';
import 'package:adc_group_project/services/database.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class NoRestaurantScreen extends StatefulWidget {
  //const NoRestaurantScreen({super.key});

  final Function checkCurrentIndex;
  NoRestaurantScreen({
    Key? key,
    required this.checkCurrentIndex,
  }) : super(key: key);

  @override
  State<NoRestaurantScreen> createState() => NoRestaurantScreenState();
}

class NoRestaurantScreenState extends State<NoRestaurantScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  final LatLng _center = const LatLng(38.660259532890706, -9.203190255573041);
  final String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';

  late Marker marker;
  
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late GoogleMapController mapController;

  String? _mapStyle;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    _loadMapStyle();
    super.initState();
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

  void _handleTap(LatLng position) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey');
    final response = await http.get(url);
    dynamic result;

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['status'] == 'OK') {
        result = json['results'][0]['formatted_address'];
      } else {
        print('Error: ${json['status']}');
        return null;
      }
    } else {
      print('Failed to fetch address');
      return null;
    }

    addressController.text = result;

    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return loading ? const LoadingScreen()
        : Scaffold(
          body: Scrollbar(
            controller: scrollController,
            child: Center(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text('Seems like you have no restaurant yet!', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                          customSpaceBetweenColumns(30),
                          Text('Add one now!', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                        ],
                      ),

                      Form(
                        key: _formKey,
                        child: Column(children: [

                          const SizedBox(height: 50),
                          textForms(nameController, 'Restaurant Name*', 'Please enter a restaurant name'),
                          const SizedBox(height: 10),
                          textForms(phoneController, 'Phone number*', 'Please enter a phone number'),
                          const SizedBox(height: 10),
                          textForms(addressController, 'Adress*', 'Please enter an address'),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: 14.0,
                              ),
                              onTap: _handleTap,
                            ),
                          ),

                        ]
                        ),
                      ),

                      Container(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await DatabaseService()
                                  .addOrUpdateRestaurantApplicationData(
                                      nameController.text,
                                      phoneController.text,
                                      addressController.text);

                              if (result == null) {
                                setState(() {
                                  loading = false;
                                });
                                // TODO: expor um erro de como falhou o envio, fazer como eu fiz no signup ou signin - jose
                              } else {
                                widget.checkCurrentIndex();
                                setState(() {
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: const Text('Send'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }

  TextFormField textForms(
      TextEditingController controller, text, String textNoValue) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: '$text*',
          labelStyle:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          )),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return textNoValue;
        }
        return null;
      },
    );
  }

  Text texts(String text, double size) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: size,
      ),
    );
  }
}
