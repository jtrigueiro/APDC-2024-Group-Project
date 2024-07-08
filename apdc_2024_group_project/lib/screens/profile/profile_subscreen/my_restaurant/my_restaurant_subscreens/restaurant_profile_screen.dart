import 'dart:io';

import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../../../utils/constants.dart';
import 'package:path/path.dart' as p;

class RestaurantPersonalizeScreen extends StatefulWidget {
  const RestaurantPersonalizeScreen({super.key});

  @override
  State<RestaurantPersonalizeScreen> createState() =>
      RestaurantPersonalizeScreenState();
}

class RestaurantPersonalizeScreenState
    extends State<RestaurantPersonalizeScreen> {
  String restaurant = '';

  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  final double _weekDaysTextBoxSize = 120;

  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  late bool mondayIsOpen;
  late bool tuesdayIsOpen;
  late bool wednesdayIsOpen;
  late bool thursdayIsOpen;
  late bool fridayIsOpen;
  late bool saturdayIsOpen;
  late bool sundayIsOpen;
  late TimeOfDay mondayFromTime;
  late TimeOfDay mondayToTime;
  late TimeOfDay tuesdayFromTime;
  late TimeOfDay tuesdayToTime;
  late TimeOfDay wednesdayFromTime;
  late TimeOfDay wednesdayToTime;
  late TimeOfDay thursdayFromTime;
  late TimeOfDay thursdayToTime;
  late TimeOfDay fridayFromTime;
  late TimeOfDay fridayToTime;
  late TimeOfDay saturdayFromTime;
  late TimeOfDay saturdayToTime;
  late TimeOfDay sundayFromTime;
  late TimeOfDay sundayToTime;
  late final dynamic data;
  XFile? pickedImageFile;
  late final dynamic currentImageUrl;

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    //restaurant = '';
    getData();
    super.initState();
  }

  Future pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          pickedImageFile = pickedFile;
        });
      }
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  getData() async {
    data = await DatabaseService().getRestaurantData();
    if (data == null) {
      Navigator.pop(context);
      loading = false;
    } else {
      restaurant = data.name;
      nameController.text = data.name;
      phoneController.text = data.phone;
      mondayIsOpen = data.isOpen[0];
      tuesdayIsOpen = data.isOpen[1];
      wednesdayIsOpen = data.isOpen[2];
      thursdayIsOpen = data.isOpen[3];
      fridayIsOpen = data.isOpen[4];
      saturdayIsOpen = data.isOpen[5];
      sundayIsOpen = data.isOpen[6];
      final String mondayfromTime = data.time[0].split('-')[0];
      final String mondaytoTime = data.time[0].split('-')[1];
      mondayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(mondayfromTime.split(":")[0]),
          int.parse(mondayfromTime.split(":")[1])));
      mondayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(mondaytoTime.split(":")[0]),
          int.parse(mondaytoTime.split(":")[1])));
      final String tuesdayfromTime = data.time[1].split('-')[0];
      final String tuesdaytoTime = data.time[1].split('-')[1];
      tuesdayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(tuesdayfromTime.split(":")[0]),
          int.parse(tuesdayfromTime.split(":")[1])));
      tuesdayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(tuesdaytoTime.split(":")[0]),
          int.parse(tuesdaytoTime.split(":")[1])));
      final String wednesdayfromTime = data.time[2].split('-')[0];
      final String wednesdaytoTime = data.time[2].split('-')[1];
      wednesdayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(wednesdayfromTime.split(":")[0]),
          int.parse(wednesdayfromTime.split(":")[1])));
      wednesdayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(wednesdaytoTime.split(":")[0]),
          int.parse(wednesdaytoTime.split(":")[1])));
      final String thursdayfromTime = data.time[3].split('-')[0];
      final String thursdaytoTime = data.time[3].split('-')[1];
      thursdayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(thursdayfromTime.split(":")[0]),
          int.parse(thursdayfromTime.split(":")[1])));
      thursdayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(thursdaytoTime.split(":")[0]),
          int.parse(thursdaytoTime.split(":")[1])));
      final String fridayfromTime = data.time[4].split('-')[0];
      final String fridaytoTime = data.time[4].split('-')[1];
      fridayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(fridayfromTime.split(":")[0]),
          int.parse(fridayfromTime.split(":")[1])));
      fridayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(fridaytoTime.split(":")[0]),
          int.parse(fridaytoTime.split(":")[1])));
      final String saturdayfromTime = data.time[5].split('-')[0];
      final String saturdaytoTime = data.time[5].split('-')[1];
      saturdayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(saturdayfromTime.split(":")[0]),
          int.parse(saturdayfromTime.split(":")[1])));
      saturdayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(saturdaytoTime.split(":")[0]),
          int.parse(saturdaytoTime.split(":")[1])));
      final String sundayfromTime = data.time[6].split('-')[0];
      final String sundaytoTime = data.time[6].split('-')[1];
      sundayFromTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(sundayfromTime.split(":")[0]),
          int.parse(sundayfromTime.split(":")[1])));
      sundayToTime = TimeOfDay.fromDateTime(DateTime(
          0,
          0,
          0,
          int.parse(sundaytoTime.split(":")[0]),
          int.parse(sundaytoTime.split(":")[1])));

      currentImageUrl = await DatabaseService().getRestaurantImageUrl();

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('My Restaurant Profile'),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          textForms(nameController, 'Restaurant Name',
                              'Please enter a restaurant name'),
                          const SizedBox(height: 10),
                          textForms(phoneController, 'Phone number',
                              'Please enter a phone number'),
                          const SizedBox(height: 10),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Open Days",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 15)),
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Text("Open Hours",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 15)),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Monday",
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 20)),
                          ),

                          Switch(
                            value: mondayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                mondayIsOpen = value;
                              });
                            },
                          ),

                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: mondayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        mondayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${mondayFromTime.hour.toString().padLeft(2, '0')}:${mondayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: mondayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        mondayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${mondayToTime.hour.toString().padLeft(2, '0')}:${mondayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Tuesday",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20)),
                          ),
                          Switch(
                            value: tuesdayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                tuesdayIsOpen = value;
                              });
                            },
                            //activeTrackColor: Colors.lightGreenAccent,
                            //activeColor: Colors.green,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: tuesdayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        tuesdayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${tuesdayFromTime.hour.toString().padLeft(2, '0')}:${tuesdayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: tuesdayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        tuesdayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${tuesdayToTime.hour.toString().padLeft(2, '0')}:${tuesdayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Wednesday",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20)),
                          ),
                          Switch(
                            value: wednesdayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                wednesdayIsOpen = value;
                              });
                            },
                            //activeTrackColor: Colors.lightGreenAccent,
                            //activeColor: Colors.green,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: wednesdayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        wednesdayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${wednesdayFromTime.hour.toString().padLeft(2, '0')}:${wednesdayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: wednesdayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        wednesdayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${wednesdayToTime.hour.toString().padLeft(2, '0')}:${wednesdayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Thursday",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20)),
                          ),
                          Switch(
                            value: thursdayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                thursdayIsOpen = value;
                              });
                            },
                            //activeTrackColor: Colors.lightGreenAccent,
                            //activeColor: Colors.green,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: thursdayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        thursdayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${thursdayFromTime.hour.toString().padLeft(2, '0')}:${thursdayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: thursdayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        thursdayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${thursdayToTime.hour.toString().padLeft(2, '0')}:${thursdayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Friday",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20)),
                          ),
                          Switch(
                            value: fridayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                fridayIsOpen = value;
                              });
                            },
                            //activeTrackColor: Colors.lightGreenAccent,
                            //activeColor: Colors.green,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: fridayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        fridayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${fridayFromTime.hour.toString().padLeft(2, '0')}:${fridayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: fridayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        fridayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${fridayToTime.hour.toString().padLeft(2, '0')}:${fridayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Saturday",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20)),
                          ),
                          Switch(
                            value: saturdayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                saturdayIsOpen = value;
                              });
                            },
                            //activeTrackColor: Colors.lightGreenAccent,
                            //activeColor: Colors.green,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: saturdayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        saturdayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${saturdayFromTime.hour.toString().padLeft(2, '0')}:${saturdayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: saturdayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        saturdayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${saturdayToTime.hour.toString().padLeft(2, '0')}:${saturdayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: _weekDaysTextBoxSize,
                            child: Text("Sunday",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontSize: 20)),
                          ),
                          Switch(
                            value: sundayIsOpen,
                            onChanged: (value) {
                              setState(() {
                                sundayIsOpen = value;
                              });
                            },
                            //activeTrackColor: Colors.lightGreenAccent,
                            //activeColor: Colors.green,
                          ),
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(225, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: sundayFromTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        sundayFromTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${sundayFromTime.hour.toString().padLeft(2, '0')}:${sundayFromTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                                const Text('to'),
                                TextButton(
                                  onPressed: () async {
                                    final TimeOfDay? timeOfDay =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: sundayToTime,
                                            initialEntryMode:
                                                TimePickerEntryMode.dial);
                                    if (timeOfDay != null) {
                                      setState(() {
                                        sundayToTime = timeOfDay;
                                      });
                                    }
                                  },
                                  child: Text(
                                      "${sundayToTime.hour.toString().padLeft(2, '0')}:${sundayToTime.minute.toString().padLeft(2, '0')}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(20),
                      Column(
                        children: [
                          pickedImageFile != null
                              ? kIsWeb
                                  ? Image.network(
                                      pickedImageFile!.path,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(pickedImageFile!.path),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                              : currentImageUrl == null
                                  ? Container()
                                  : Builder(
                                      builder: (context) {
                                        return Image.network(
                                          currentImageUrl,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Text(
                                                      'Error loading image!'),
                                        );
                                      },
                                    ),
                          ElevatedButton(
                            onPressed: () {
                              pickImage();
                            },
                            child: const Icon(Icons.add),
                          ),
                          currentImageUrl == null
                              ? Text("Add Restaurant Photo",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 15))
                              : Text("Update Restaurant Photo",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 15)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final List<bool> isOpen = [
                                  sundayIsOpen,
                                  mondayIsOpen,
                                  tuesdayIsOpen,
                                  wednesdayIsOpen,
                                  thursdayIsOpen,
                                  fridayIsOpen,
                                  saturdayIsOpen
                                ];
                                final List<String> time = [
                                  "${mondayFromTime.hour}:${mondayFromTime.minute}-${mondayToTime.hour}:${mondayToTime.minute}",
                                  "${tuesdayFromTime.hour}:${tuesdayFromTime.minute}-${tuesdayToTime.hour}:${tuesdayToTime.minute}",
                                  "${wednesdayFromTime.hour}:${wednesdayFromTime.minute}-${wednesdayToTime.hour}:${wednesdayToTime.minute}",
                                  "${thursdayFromTime.hour}:${thursdayFromTime.minute}-${thursdayToTime.hour}:${thursdayToTime.minute}",
                                  "${fridayFromTime.hour}:${fridayFromTime.minute}-${fridayToTime.hour}:${fridayToTime.minute}",
                                  "${saturdayFromTime.hour}:${saturdayFromTime.minute}-${saturdayToTime.hour}:${saturdayToTime.minute}",
                                  "${sundayFromTime.hour}:${sundayFromTime.minute}-${sundayToTime.hour}:${sundayToTime.minute}"
                                ];
                                // Check if the data has changed, to avoid unnecessary calls to the database
                                if (data.name != nameController.text ||
                                    data.phone != phoneController.text ||
                                    listEquals(isOpen, data.isOpen) == false ||
                                    listEquals(time, data.time) == false) {
                                  final databaseStatus = await DatabaseService()
                                      .updateRestaurantData(nameController.text,
                                          phoneController.text, isOpen, time);
                                  if (databaseStatus == null) {
                                    return;
                                  }
                                }
                                if (pickedImageFile != null) {
                                  if (kIsWeb) {
                                    await DatabaseService()
                                        .uploadRestaurantImageWeb(
                                            await pickedImageFile!
                                                .readAsBytes(),
                                            p.extension(pickedImageFile!.name));
                                  } else {
                                    await DatabaseService()
                                        .uploadRestaurantImageMobile(
                                            pickedImageFile!.path);
                                  }
                                }

                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Save'),
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
}
