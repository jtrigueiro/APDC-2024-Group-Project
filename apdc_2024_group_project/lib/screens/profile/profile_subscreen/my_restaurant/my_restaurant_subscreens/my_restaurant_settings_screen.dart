import 'package:adc_group_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantSettingsScreen extends StatefulWidget {
  MyRestaurantSettingsScreen({super.key});

  @override
  State<MyRestaurantSettingsScreen> createState() =>
      MyRestaurantSettingsScreenState();
}

class MyRestaurantSettingsScreenState
    extends State<MyRestaurantSettingsScreen> {
  late ScrollController scrollController;

  bool visible = false;
  bool open = false;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Restaurant'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 117, 85, 18)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaceBetweenColumns(20),
                Text('Activity', style: Theme.of(context).textTheme.titleMedium),
                const Divider(thickness: 2, color: Color.fromARGB(255, 182, 141, 64)),

                Column(
                  children: [
                    activitySettings('Visible', visible, visibleSetting),
                    activitySettings('Open', open, openSetting),
                  ],
                ),

                customSpaceBetweenColumns(100),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                        foregroundColor: Theme.of(context).colorScheme.onError,
                      ),
                      child: Text('Delete Restaurant', style: TextStyle(color:Theme.of(context).colorScheme.onError ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row activitySettings(String title, bool val, Function onChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.normal, color: Theme.of(context).colorScheme.secondary) ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: val,
            activeColor:  Theme.of(context).colorScheme.secondary,
            inactiveThumbColor: Theme.of(context).colorScheme.secondary,
            trackOutlineColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary) ,
            onChanged: (bool value) {
              onChange(value);
            },
          ),
        ),
      ],
    );
  }

  visibleSetting(bool newValue) {
    setState(() {
      visible = newValue;
    });
  }

  openSetting(bool newValue) {
    setState(() {
      open = newValue;
    });
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
