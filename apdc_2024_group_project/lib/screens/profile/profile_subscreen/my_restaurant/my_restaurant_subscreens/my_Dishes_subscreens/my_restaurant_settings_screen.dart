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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: texts('Settings', 20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              texts('Activity', 16),
              Divider(thickness: 2),
              activitySettings('Visible', visible, visibleSetting),
              activitySettings('Open', open, openSetting),
              customSpaceBetweenColumns(100),
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: texts('Delete Restaurant', 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding activitySettings(String title, bool val, Function onChange) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            texts(title, 16),
            Transform.scale(
              scale: 0.7,
              child: Switch(
                value: val,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  onChange(value);
                },
              ),
            ),
          ],
        ));
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
