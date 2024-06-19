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
              Text("You have already made a requested,", style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
              Text("wait for our approval.", style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
              Text("You will be contacted soon.", style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),

              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const HelpAndSupportScreen()));
                },

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
