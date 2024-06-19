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

    super.initState();
  }

  //selectdays in week
 final List<DayInWeek> _days = [
   DayInWeek('Sun', dayKey: 'Sun'),
   DayInWeek('Mon', dayKey: 'Mon'),
   DayInWeek('Tue', dayKey: 'Tue'),
   DayInWeek('Wed', dayKey: 'Wed'),
   DayInWeek('Thu', dayKey: 'Thu'),
   DayInWeek('Sat', dayKey: 'Sat'),

  ];

  final _dayPick = ListPickerField(
    label: 'Week Days',
    items: const [ "Sun", "Tue", "Wed", "Thu", "Fri", "Sat"]
  );

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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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

                ListPickerField(
                    label: 'Week Days',
                    items: const [ "Sunday", "Tuesday", "Wednesday", "Thurday", "Friday", "Saturday"]
                ),

                  SelectWeekDays(
                      onSelect: (values) {}, 
                      days: _days,
                  ),


                  ElevatedButton(
                    onPressed: () async {
                     String? fruit = await showPickerDialog(
                        context: context,
                        label: "Weekdays",
                          items: const [ "Sunday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                      );

                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                         content: Text(fruit ?? "No weekday selected"),
                       ),
                     );
                     },
                    child: const Text("Open Days"),
                  ),

                  Text("Open Days", style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),

                  Row(
                    children: [

                      Text("Sun", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: const Color.fromARGB(255, 182, 141, 64))),
                      Checkbox(
                          activeColor: const Color.fromARGB(255, 182, 141, 64),
                          value: sunday,
                          onChanged: (bool? value) {
                            setState(() {
                              sunday = value!;
                            });
                          }
                      ),

                      Text("Mon", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: const Color.fromARGB(255, 182, 141, 64))),
                      Checkbox(
                          activeColor: const Color.fromARGB(255, 182, 141, 64),
                          value: monday,
                          onChanged: (bool? value) {
                            setState(() {
                              monday = value!;
                            });
                          }
                      ),

                      Text("Tue", style: Theme.of(context).textTheme.displaySmall!.copyWith(color: const Color.fromARGB(255, 182, 141, 64))),
                      Checkbox(
                          activeColor: const Color.fromARGB(255, 182, 141, 64),
                          value: tuesday,
                          onChanged: (bool? value) {
                            setState(() {
                              tuesday = value!;
                            });
                          }
                      ),

                    ]
                  ),

                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                          Navigator.pop(context);
                      },
                      child: const Text('Save'),
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




