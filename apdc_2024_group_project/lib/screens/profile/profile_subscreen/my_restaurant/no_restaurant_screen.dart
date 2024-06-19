import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/services/database.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  bool loading = false;
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
                          Text('Seems like you have nos restaurant yet!', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
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
                          textForms(locationController, 'Location*', 'Please enter a location'),
                          const SizedBox(height: 30),
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
                                      locationController.text);

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
}
