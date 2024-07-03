import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class NoRestaurantScreen extends StatefulWidget {
  final Function checkCurrentIndex;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NoRestaurantScreen({
    super.key,
    required this.checkCurrentIndex,
  });

  @override
  State<NoRestaurantScreen> createState() => NoRestaurantScreenState();
}

class NoRestaurantScreenState extends State<NoRestaurantScreen> {
  static const String apiKey = "AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug";
  static const String noRestaurantText = "Seems like you have no restaurant yet!\nAdd one now!";

  final ScrollController scrollController = ScrollController(); 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController routeController = TextEditingController();
  final TextEditingController cpController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController _numberOfSeatsController = TextEditingController();
  final TextEditingController _co2EmissionEstimateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final RegExp _numeric = RegExp(r'\d');
  final RegExp _decimal = RegExp(r'(^\d*\.?\d*)');
  
  late String _address;
  late String _coordinates;
  late String _location;

  File? _electricityPdf;
  File? _gasPdf;
  File? _waterPdf;
  Uint8List? _electricityPdfBytes;
  Uint8List? _gasPdfBytes;
  Uint8List? _waterPdfBytes;
  String? _electricityPdfError;
  String? _gasPdfError;
  String? _waterPdfError;

  Future<void> _pickFile(String fileType) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        setState(() {
          if (kIsWeb) {
            if (fileType == 'electricity') {
              _electricityPdfBytes = result.files.single.bytes;
            } else if (fileType == 'gas') {
              _gasPdfBytes = result.files.single.bytes;
            } else if (fileType == 'water') {
              _waterPdfBytes = result.files.single.bytes;
            }
          } else {
            if (fileType == 'electricity') {
              _electricityPdf = File(result.files.single.path!);
            } else if (fileType == 'gas') {
              _gasPdf = File(result.files.single.path!);
            } else if (fileType == 'water') {
              _waterPdf = File(result.files.single.path!);
            }
          }
        });
      } else {
        print('File selection cancelled');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      _electricityPdfError =
          _electricityPdf == null && _electricityPdfBytes == null
              ? 'Please upload the last month of electricity bill'
              : null;
      _gasPdfError = _gasPdf == null && _gasPdfBytes == null
          ? 'Please upload the last month of gas bill'
          : null;
      _waterPdfError = _waterPdf == null && _waterPdfBytes == null
          ? 'Please upload the last month of water bill'
          : null;
    });

    if (_formKey.currentState!.validate() &&
        _electricityPdfError == null &&
        _gasPdfError == null &&
        _waterPdfError == null &&
        await validateAddress()) {
      setState(() {
        loading = true;
      });

      try {
        // Upload files
        String? electricityUrl;
        String? gasUrl;
        String? waterUrl;

        print('Uploading electricity PDF...');
        electricityUrl = await StorageService().uploadFile(
            _electricityPdfBytes ?? await _electricityPdf!.readAsBytes(),
            'electricity_.pdf',
            widget._auth.currentUser!);

        print('Uploading gas PDF...');
        gasUrl = await StorageService().uploadFile(
            _gasPdfBytes ?? await _gasPdf!.readAsBytes(),
            'gas_.pdf',
            widget._auth.currentUser!);

        print('Uploading water PDF...');
        waterUrl = await StorageService().uploadFile(
            _waterPdfBytes ?? await _waterPdf!.readAsBytes(),
            'water_.pdf',
            widget._auth.currentUser!);

        if (electricityUrl == null || gasUrl == null || waterUrl == null) {
          print('Failed to upload one or more files');
          setState(() {
            loading = false;
          });
          return;
        }

        dynamic result =
            await DatabaseService().addOrUpdateRestaurantApplicationData(
          nameController.text,
          phoneController.text,
          _address,
          _location,
          int.parse(_numberOfSeatsController.text),
          double.parse(_co2EmissionEstimateController.text),
          _coordinates,
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

  Future<bool> validateAddress() {
    String address = "${streetNumberController.text} ${routeController.text}, ${cpController.text} ${countryController.text}";

    if (address.isEmpty) {
      return Future.value(false);
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey');
    return http.get(url).then((response) {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final size = json['results'][0]['address_components'].length;

          _address = json['results'][0]['formatted_address'];
          _location = json['results'][0]['address_components'][size - 4]['long_name'].toString().toLowerCase();
          _coordinates = '${json['results'][0]['geometry']['location']['lat']},${json['results'][0]['geometry']['location']['lng']}';

          return true;
        } else {
          print('Failed to fetch address: ${response.statusCode}');

          return false;
        }
      } else {
        print('Failed to fetch address: ${response.statusCode}');
        return false;
      }
    }).catchError((e) {
      print('Error fetching address: $e');
      return false;
    });

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
                        const SizedBox(height: 20),
                        const Text(
                          noRestaurantText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              buildTextFormField("Restaurant name", nameController, TextInputType.text, null, 70),
                              const SizedBox(height: 10),
                              buildTextFormField("Phone number", phoneController, TextInputType.phone, _numeric, 15),
                              const SizedBox(height: 10),
                              buildDoubleTextForm("Street number", "Route", streetNumberController, routeController, TextInputType.text),
                              const SizedBox(height: 10),
                              buildDoubleTextForm("Postal Code", "Country", cpController, countryController, TextInputType.text),
                              const SizedBox(height: 10),
                              buildTextFormField("Number of seats", _numberOfSeatsController, TextInputType.number, _numeric, 5),
                              const SizedBox(height: 10),
                              buildTextFormField("GHGs emissions estimate", _co2EmissionEstimateController, const TextInputType.numberWithOptions(decimal: true), _decimal, 8),
                              const SizedBox(height: 20),
                              buildPdfButton("Electricity", _electricityPdf, _electricityPdfBytes, _electricityPdfError),
                              const SizedBox(height: 10),
                              buildPdfButton("Gas", _gasPdf, _gasPdfBytes, _gasPdfError),
                              const SizedBox(height: 10),
                              buildPdfButton("Water", _waterPdf, _waterPdfBytes, _waterPdfError),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _submitForm,
                                child: const Text("Submit Application"),
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

  Row buildDoubleTextForm(String label1, String label2, TextEditingController controller1,
      TextEditingController controller2, TextInputType keyboardType) {
    return Row(
      children: [
        Expanded(
          child: buildTextFormField(label1, controller1, keyboardType, null, null)
        ),
        const SizedBox(width: 5),
        Expanded(
          child: buildTextFormField(label2, controller2, keyboardType, null, null)
        ),
      ],
    );
  }

  TextFormField buildTextFormField(String label, TextEditingController controller,
      TextInputType keyboardType, RegExp? regExp, int? maxLength) {
    return TextFormField(
      maxLength: maxLength,
      controller: controller,
      decoration: InputDecoration(
        labelText: "$label(*)",
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(regExp ?? RegExp(r'.*', dotAll: true)),
      ],
      validator: (value) => validateString(value, "$label is required."),
    );
  }

  String? validateString(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  Column buildPdfButton(String label, File? file, Uint8List? bytes, String? error) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _pickFile(label.toLowerCase()),
          child: Text(
            file == null && bytes == null
                ? "Upload Last Month's $label Bill(*)"
                : "$label File Selected",
          ),
        ),
        error != null
            ? Text(error,) : Container(),
      ],
    );
  }
}
