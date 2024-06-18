import 'package:adc_group_project/screens/profile/profile_subscreen/help_and_support/help_and_support.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantRequestScreen extends StatefulWidget {
  const RestaurantRequestScreen({super.key});

  @override
  State<RestaurantRequestScreen> createState() =>
      RestaurantRequestScreenState();
}

class RestaurantRequestScreenState extends State<RestaurantRequestScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: Center(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(children: [
              texts("You have already made a requested,", 20),
              texts("wait for our approval.", 20),
              texts("You will be contacted soon.", 20),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const HelpAndSupportScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.green[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Help & Support'),
              ),
            ]),
          ),
        ),
      ),
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
