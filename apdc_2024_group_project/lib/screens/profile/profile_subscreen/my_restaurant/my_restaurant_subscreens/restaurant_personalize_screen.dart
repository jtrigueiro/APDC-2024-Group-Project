import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_picker/list_picker.dart';

import '../../../../../utils/constants.dart';

class RestaurantPersonalizeScreen extends StatefulWidget {
  const RestaurantPersonalizeScreen({super.key});

  @override
  State<RestaurantPersonalizeScreen> createState() => RestaurantPersonalizeScreenState();
}

class RestaurantPersonalizeScreenState extends State<RestaurantPersonalizeScreen> {
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  late TextEditingController weekDaysController;
  late TextEditingController hourController;
  late TextEditingController minutesController;

  final _formKey = GlobalKey<FormState>();

  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = false;
  bool sunday = false;


  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    locationController = TextEditingController();

    weekDaysController = TextEditingController();
    hourController = TextEditingController();
    minutesController = TextEditingController();

    super.initState();
  }
  

  TimeOfDay selectFromTime = TimeOfDay.fromDateTime(DateTime(0));
  TimeOfDay selectToTime = TimeOfDay.fromDateTime(DateTime(0));
 
  TextButton textTimeButton (TimeOfDay time)
  {
    return TextButton(
      onPressed: () async {
        final TimeOfDay? timeOfDay = await showTimePicker(
            context: context,
            initialTime: time,
            initialEntryMode: TimePickerEntryMode.dial
        );
        if(timeOfDay != null)
        {
          setState(() {
            time = timeOfDay;
          });
        }
      },
      child:  Text("${time.hour}:${time.minute}", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),

    );
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                        children: [

                          SizedBox(height: 20),
                          textForms(nameController, 'Restaurant Name', 'Please enter a restaurant name'),

                          const SizedBox(height: 10),

                          textForms(phoneController, 'Phone number','Please enter a phone number'),

                          const SizedBox(height: 10),
                          textForms(locationController, 'Location','Please enter a location'),

                          const SizedBox(height: 10),

                        ]
                    ),
                  ),

                  spaceBetweenColumns(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Open Days", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),

                      Text("Open Hours", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: ListPickerField(
                          controller: weekDaysController,
                          label: 'Week Days',
                          items: const [ "Sunday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                        ),
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(226, 239, 239, 239),
                          borderRadius: BorderRadius.circular(10),
                        ) ,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? timeOfDay = await showTimePicker(
                                    context: context,
                                    initialTime: selectFromTime,
                                    initialEntryMode: TimePickerEntryMode.dial
                                );
                                if(timeOfDay != null)
                                {
                                  setState(() {
                                    selectFromTime = timeOfDay;
                                  });
                                }
                              },
                              child:  Text("${selectFromTime.hour.toString().padLeft(2,'0')}:${selectFromTime.minute.toString().padLeft(2,'0')}", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),

                            ),

                            const Text('to'),

                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? timeOfDay = await showTimePicker(
                                    context: context,
                                    initialTime: selectToTime,
                                    initialEntryMode: TimePickerEntryMode.dial
                                );
                                if(timeOfDay != null)
                                {
                                  setState(() {
                                    selectToTime = timeOfDay;
                                  });
                                }
                              },
                              child:  Text("${selectToTime.hour.toString().padLeft(2,'0')}:${selectToTime.minute.toString().padLeft(2,'0')}", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                 ElevatedButton(
                      onPressed: () { },
                      child:  Text("Add Open hours"),
                    ),


                  customSpaceBetweenColumns(20),

                  Column(
                    children: [
                      Text("Add Restaurant Photos", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),
                      ElevatedButton(
                        onPressed: () { },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,50,0,0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *0.6,
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




