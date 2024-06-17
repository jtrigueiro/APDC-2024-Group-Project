import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/restaurant_requested_screen.dart';
import 'package:adc_group_project/services/auth.dart';
//import 'package:adc_group_project/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoRestaurantScreen extends StatefulWidget {
  //const NoRestaurantScreen({super.key});

  Function checkCurrentIndex;
  NoRestaurantScreen({
    Key? key,
    required this.checkCurrentIndex,
  }) : super(key: key);

  @override
  State<NoRestaurantScreen> createState() => NoRestaurantScreenState();
}

class NoRestaurantScreenState extends State<NoRestaurantScreen> {
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    texts('Seems like you have no restaurant yet!', 20),
                    texts('Add one now!', 20),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    const SizedBox(height: 50),
                    textForms(nameController, 'Restaurant Name',
                        'Please enter a restaurant name'),
                    const SizedBox(height: 10),
                    textForms(phoneController, 'Phone number',
                        'Please enter a phone number'),
                    const SizedBox(height: 10),
                    textForms(locationController, 'Location',
                        'Please enter a location'),
                    const SizedBox(height: 30),
                  ]),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.registerRestaurantApplication(
                                nameController.text,
                                phoneController.text,
                                locationController.text);
                        if (result == null) {
                          // TODO: expor um erro de como falhou o envio
                        } else {
                          widget.checkCurrentIndex();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontStyle: FontStyle.italic),
                      backgroundColor: Colors.green[100],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Send'),
                  ),
                ),
              ],
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
        color: const Color(0xFF000000),
      ),
    );
  }
}
