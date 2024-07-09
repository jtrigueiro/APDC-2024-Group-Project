import 'dart:async';
import 'dart:io';
import 'package:adc_group_project/services/geocoding.dart';
import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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
  static const String noRestaurantText =
      "Seems like you have no restaurant yet!\nAdd one now!";

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

  List<MultiSelectItem<String>> _restaurantTypeItems = [];
  List<String> _selectedRestaurantTypes = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurantTypes();
  }

  Future<void> _loadRestaurantTypes() async {
    try {
      List<DocumentSnapshot> types =
          await DatabaseService().getRestaurantTypes();
      setState(() {
        _restaurantTypeItems = types.map((type) {
          final data = type.data() as Map<String, dynamic>;
          return MultiSelectItem<String>(type.id, data['name']);
        }).toList();
      });
    } catch (e) {
      print("Error loading restaurant types: $e");
    }
  }

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
      } else {}
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

        electricityUrl = await StorageService().uploadFile(
            _electricityPdfBytes ?? await _electricityPdf!.readAsBytes(),
            'electricity_.pdf',
            widget._auth.currentUser!);

        gasUrl = await StorageService().uploadFile(
            _gasPdfBytes ?? await _gasPdf!.readAsBytes(),
            'gas_.pdf',
            widget._auth.currentUser!);

        waterUrl = await StorageService().uploadFile(
            _waterPdfBytes ?? await _waterPdf!.readAsBytes(),
            'water_.pdf',
            widget._auth.currentUser!);

        if (electricityUrl == null || gasUrl == null || waterUrl == null) {
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
          _selectedRestaurantTypes,
        );

        if (result == null) {
          setState(() {
            loading = false;
          });
        } else {
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
          scrollable: true,
          title: const Text("Confirmation", textAlign: TextAlign.center),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Is this the correct address?',
                  style: Theme.of(context).textTheme.titleSmall),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(message,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
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

  Future<bool> validateAddress() async {
    String address =
        "${streetNumberController.text} ${routeController.text}, ${cpController.text} ${countryController.text}";

    try {
      final value = await GeocodingService().geocode(address);

      if (value['status'] == 'OK') {
        final addressComponents =
            value['results'][0]['address_components'] as List<dynamic>;
        final int size = addressComponents.length;

        _address = value['results'][0]['formatted_address'] as String;
        _location =
            addressComponents[size - 4]['long_name'].toString().toLowerCase();
        _coordinates =
            '${value['results'][0]['geometry']['location']['lat']},${value['results'][0]['geometry']['location']['lng']}';

        final confirmation = await _showConfirmationDialog(_address);
        return bool.parse(confirmation.toString());
      } else {
        _showErrorDialog(
            "There were no results for the given address.\nPlease check the address and try again.\nIf the problem persists, please contact the support team.");
        return false;
      }
    } catch (e) {
      _showErrorDialog("Error validating address: $e");
      return false;
    }
  }

  changecolor(file, bytes) {
    if (file == null && bytes == null) {
      return ElevatedButton.styleFrom(backgroundColor: Colors.grey);
    } else {
      return ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary);
    }
  }

  Padding buildPdfButton(IconData icon, String label, File? file,
      Uint8List? bytes, String? error) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            style: changecolor(file, bytes),
            icon: Icon(icon),
            onPressed: () => _pickFile(label.toLowerCase()),
            label: Text(
              file == null && bytes == null
                  ? "Upload Last Month's $label Bill*"
                  : "$label File Uploaded",
            ),
          ),
          error != null
              ? Text(error,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.error))
              : Container(),
        ],
      ),
    );
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
                              buildTextFormField("Restaurant name",
                                  nameController, TextInputType.text, null, 70),
                              const SizedBox(height: 10),
                              buildTextFormField(
                                  "Phone number",
                                  phoneController,
                                  TextInputType.phone,
                                  _numeric,
                                  15),
                              const SizedBox(height: 10),
                              buildDoubleTextForm(
                                  "Street number",
                                  "Street Address",
                                  streetNumberController,
                                  routeController,
                                  TextInputType.text),
                              const SizedBox(height: 10),
                              buildDoubleTextForm(
                                  "Postal Code",
                                  "Country",
                                  cpController,
                                  countryController,
                                  TextInputType.text),
                              const SizedBox(height: 10),
                              buildTextFormField(
                                  "Number of seats",
                                  _numberOfSeatsController,
                                  TextInputType.number,
                                  _numeric,
                                  3),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: MultiSelectDialogField(
                                  dialogHeight:
                                      MediaQuery.of(context).size.height * 0.4,
                                  buttonIcon:
                                      const Icon(Icons.arrow_drop_down_sharp),
                                  items: _restaurantTypeItems,
                                  title: const Text("Restaurant Types"),
                                  selectedColor:
                                      Theme.of(context).colorScheme.primary,
                                  buttonText:
                                      const Text("Select Restaurant Types"),
                                  onConfirm: (results) {
                                    _selectedRestaurantTypes =
                                        results.cast<String>();
                                  },
                                  validator: (values) {
                                    if (values == null || values.isEmpty) {
                                      return "Please select at least one restaurant type.";
                                    }
                                    return null;
                                  },
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
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary),
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
      Expanded(
          child: buildTextFormField(
              label2, controller2, keyboardType, null, null)),
    ],
  );
}

Padding buildTextFormFieldPhone(
    String label, TextEditingController controller, RegExp? regExp) {
  return Padding(
    padding: const EdgeInsets.all(3),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "$label*",
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      minLines: 9,
      validator: (value) => validateString(value, "$label is required."),
    ),
  );
}

Padding buildTextFormField(String label, TextEditingController controller,
    TextInputType keyboardType, RegExp? regExp, int? maxLength) {
  return Padding(
    padding: const EdgeInsets.all(3),
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
