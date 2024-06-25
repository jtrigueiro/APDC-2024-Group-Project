import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:adc_group_project/services/database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:adc_group_project/services/database.dart';

class NoRestaurantScreen extends StatefulWidget {
  final Function checkCurrentIndex;
  NoRestaurantScreen({
    Key? key,
    required this.checkCurrentIndex,
  }) : super(key: key);

  @override
  State<NoRestaurantScreen> createState() => NoRestaurantScreenState();
}

class NoRestaurantScreenState extends State<NoRestaurantScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
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
  File? _electricityPdf;
  File? _gasPdf;
  Uint8List? _electricityPdfBytes;
  Uint8List? _gasPdfBytes;

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
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
    if (_mapStyle != null) {
      controller.setMapStyle(_mapStyle);
    }
  }

  Future<void> _handleTap(LatLng position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final result = json['results'][0]['formatted_address'];
          addressController.text = result;
        } else {
          print('Error: ${json['status']}');
        }
      } else {
        print('Failed to fetch address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
  }

  Future<void> _pickFile(bool isElectricity) async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        if (kIsWeb) {
          setState(() {
            if (isElectricity) {
              _electricityPdfBytes = result.files.single.bytes;
            } else {
              _gasPdfBytes = result.files.single.bytes;
            }
          });
        } else {
          setState(() {
            if (isElectricity) {
              _electricityPdf = File(result.files.single.path!);
            } else {
              _gasPdf = File(result.files.single.path!);
            }
          });
        }
      } else {
        print('File selection cancelled');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<String?> _uploadFile(Uint8List fileBytes, String fileName) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      final metadata = SettableMetadata(contentType: 'application/pdf');
      await storageRef.putData(fileBytes, metadata);
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Failed to upload file: $e');
      return null;
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        // Upload files
        String? electricityUrl;
        String? gasUrl;

        if (_electricityPdf != null || _electricityPdfBytes != null) {
          print('Uploading electricity PDF...');
          electricityUrl = await DatabaseService().uploadFile(
              _electricityPdfBytes ?? await _electricityPdf!.readAsBytes(),
              'electricity_${DateTime.now().millisecondsSinceEpoch}.pdf');
        }

        if (_gasPdf != null || _gasPdfBytes != null) {
          print('Uploading gas PDF...');
          gasUrl = await DatabaseService().uploadFile(
              _gasPdfBytes ?? await _gasPdf!.readAsBytes(),
              'gas_${DateTime.now().millisecondsSinceEpoch}.pdf');
        }

        if (electricityUrl == null || gasUrl == null) {
          print('Failed to upload one or both files');
          setState(() {
            loading = false;
          });
          return;
        }

        // Example of using DatabaseService for Firebase operations
        dynamic result =
            await DatabaseService().addOrUpdateRestaurantApplicationData(
          nameController.text,
          phoneController.text,
          addressController.text,
          electricityUrl,
          gasUrl,
        );

        if (result == null) {
          print('Failed to submit application data');
          setState(() {
            loading = false;
          });
        } else {
          print('Application data submitted successfully');
          widget.checkCurrentIndex();
          setState(() {
            loading = false;
          });
        }
      } catch (e) {
        print('Error submitting application data: $e');
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
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
                            Text('Seems like you have no restaurant yet!',
                                textAlign: TextAlign.center),
                            SizedBox(height: 10),
                            Text('Add one now!', textAlign: TextAlign.center),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: 'Restaurant Name*',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a restaurant name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Phone number*',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  labelText: 'Address*',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an address';
                                  }
                                  return null;
                                },
                              ),
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
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => _pickFile(true),
                                child: Text(
                                  _electricityPdf == null &&
                                          _electricityPdfBytes == null
                                      ? 'Upload Last 3 Months of Electricity Bills'
                                      : 'Electricity PDF Selected',
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () => _pickFile(false),
                                child: Text(
                                  _gasPdf == null && _gasPdfBytes == null
                                      ? 'Upload Last 3 Months of Gas Bills'
                                      : 'Gas PDF Selected',
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _submitForm,
                                child: const Text('Send'),
                              ),
                            ],
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
}
