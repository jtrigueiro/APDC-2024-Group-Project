import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_picker/list_picker.dart';

import '../../../../../utils/constants.dart';

class RestaurantPersonalizeScreen extends StatefulWidget {
  const RestaurantPersonalizeScreen({super.key});

  @override
  State<RestaurantPersonalizeScreen> createState() =>
      RestaurantPersonalizeScreenState();
}

class RestaurantPersonalizeScreenState
    extends State<RestaurantPersonalizeScreen> {
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  final double _weekDaysTextBoxSize = 110;

  final _formKey = GlobalKey<FormState>();

  bool mondayIsOpen = true;
  bool tuesdayIsOpen = true;
  bool wednesdayIsOpen = true;
  bool thursdayIsOpen = true;
  bool fridayIsOpen = true;
  bool saturdayIsOpen = true;
  bool sundayIsOpen = true;
  TimeOfDay mondayFromTime = TimeOfDay.fromDateTime(DateTime(0, 0, 0, 10, 10));
  TimeOfDay mondayToTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay tuesdayFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay tuesdayToTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay wednesdayFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay wednesdayToTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay thursdayFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay thursdayToTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay fridayFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay fridayToTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay saturdayFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay saturdayToTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay sundayFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay sundayToTime = TimeOfDay.fromDateTime(DateTime(0));

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();

    super.initState();
  }

  TextButton textTimeButton(TimeOfDay time) {
    return TextButton(
      onPressed: () async {
        final TimeOfDay? timeOfDay = await showTimePicker(
            context: context,
            initialTime: time,
            initialEntryMode: TimePickerEntryMode.dial);
        if (timeOfDay != null) {
          setState(() {
            time = timeOfDay;
          });
        }
      },
      child: Text("${time.hour}:${time.minute}",
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Restaurant Info'),
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    SizedBox(height: 20),
                    textForms(nameController, 'Restaurant Name',
                        'Please enter a restaurant name'),
                    const SizedBox(height: 10),
                    textForms(
                        // TODO: phone number has to be an integer - jose
                        phoneController,
                        'Phone number',
                        'Please enter a phone number'),
                    const SizedBox(height: 10),
                    /*textForms(locationController, 'Location',
                        'Please enter a location'),
                    const SizedBox(height: 10),*/
                  ]),
                ),
                spaceBetweenColumns(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Open Days",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15)),
                    Text("Open Hours",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: _weekDaysTextBoxSize,
                      child: Text("Monday",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 20)),
                    ),
                    Switch(
                      value: mondayIsOpen,
                      onChanged: (value) {
                        setState(() {
                          mondayIsOpen = value;
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: mondayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: mondayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: tuesdayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: tuesdayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: wednesdayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
                              if (timeOfDay != null) {
                                setState(() {
                                  tuesdayFromTime = timeOfDay;
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: wednesdayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: thursdayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: thursdayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: fridayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: fridayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: saturdayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: saturdayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: sundayFromTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                  context: context,
                                  initialTime: sundayToTime,
                                  initialEntryMode: TimePickerEntryMode.dial);
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
                    Text("Add Restaurant Photos",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15)),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
