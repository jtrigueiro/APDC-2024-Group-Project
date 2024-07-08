import 'dart:async';
import 'dart:io';
import 'package:adc_group_project/services/geocoding.dart';
import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final ScrollController scrollController = ScrollController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController routeController = TextEditingController();
  final TextEditingController cpController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController _numberOfSeatsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final RegExp _numeric = RegExp(r'\d');

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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
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
            await DatabaseService().createOrOverwriteRestaurantApplicationData(
          nameController.text,
          phoneController.text,
          _address,
          _location,
          int.parse(_numberOfSeatsController.text),
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

  Future _showConfirmationDialog(String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> validateAddress() {
    String address =
        "${streetNumberController.text} ${routeController.text}, ${cpController.text} ${countryController.text}";

    return GeocodingService().geocode(address).then((value) async {
      if (value['status'] == 'OK') {
        final int size = value['results'][0]['address_components'].length;

        _address = value['results'][0]['formatted_address'];
        _location = value['results'][0]['address_components'][size - 4]
                ['long_name']
            .toString()
            .toLowerCase();
        _coordinates =
            '${value['results'][0]['geometry']['location']['lat']},${value['results'][0]['geometry']['location']['lng']}';

        final confirmation = await _showConfirmationDialog(
            "Is this the correct address?\n$_address");
        return bool.parse(confirmation.toString());
      } else {
        _showErrorDialog(
            "There were no results for the given address.\nPlease check the address and try again.\nIf the problem persists, please contact the support team.");
        return false;
      }
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          "Seems like you have no restaurant yet!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'Add one now',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildTextFormField("Restaurant name",
                                  nameController, TextInputType.text, null, 70),
                              buildTextFormField(
                                  "Phone number",
                                  phoneController,
                                  TextInputType.phone,
                                  _numeric,
                                  15),
                              buildDoubleTextForm(
                                  "Street number",
                                  "Route",
                                  streetNumberController,
                                  routeController,
                                  TextInputType.text),
                              buildDoubleTextForm(
                                  "Postal Code",
                                  "Country",
                                  cpController,
                                  countryController,
                                  TextInputType.text),
                              buildTextFormField(
                                  "Number of seats",
                                  _numberOfSeatsController,
                                  TextInputType.number,
                                  _numeric,
                                  3),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '* Required Fields',
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.black38,
                                      ),
                                ),
                              ),
                              buildPdfButton(
                                  Icons.lightbulb,
                                  "Electricity",
                                  _electricityPdf,
                                  _electricityPdfBytes,
                                  _electricityPdfError),
                              buildPdfButton(Icons.gas_meter_outlined, "Gas",
                                  _gasPdf, _gasPdfBytes, _gasPdfError),
                              buildPdfButton(Icons.water_drop, "Water",
                                  _waterPdf, _waterPdfBytes, _waterPdfError),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
                                  onPressed: _submitForm,
                                  child: const Text("Submit Application"),
                                ),
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

  Row buildDoubleTextForm(
      String label1,
      String label2,
      TextEditingController controller1,
      TextEditingController controller2,
      TextInputType keyboardType) {
    return Row(
      children: [
        Expanded(
            child: buildTextFormField(
                label1, controller1, keyboardType, null, null)),
        const SizedBox(width: 5),
        Expanded(
            child: buildTextFormField(
                label2, controller2, keyboardType, null, null)),
      ],
    );
  }

  Padding buildTextFormField(String label, TextEditingController controller,
      TextInputType keyboardType, RegExp? regExp, int? maxLength) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "$label*",
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(maxLength),
          FilteringTextInputFormatter.allow(
              regExp ?? RegExp(r'.*', dotAll: true)),
        ],
        validator: (value) => validateString(value, "$label is required."),
      ),
    );
  }

  String? validateString(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  Column buildPdfButton(IconData icon, String label, File? file,
      Uint8List? bytes, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 25)),
          icon: Icon(icon),
          onPressed: () => _pickFile(label.toLowerCase()),
          label: Text(
            file == null && bytes == null
                ? "Upload Last Month's $label Bill(*)"
                : "$label File Uploaded",

          ),
        ),
        error != null
            ? Text(
                error,
              )
            : Container(),
      ],
    );
  }
}
