import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 182, 141, 64),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: texts('My Restaurant', 20),
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
                          texts("Restaurant Name",10),
                          textForms(nameController, 'Restaurant Name', 'Please enter a restaurant name'),

                          const SizedBox(height: 10),
                          texts("Phone Number",10),
                          textForms(phoneController, 'Phone number','Please enter a phone number'),

                          const SizedBox(height: 10),
                          texts("Location",10),
                          textForms(locationController, 'Location','Please enter a location'),

                          const SizedBox(height: 10),

                        ]
                    ),
                  ),

                  texts("Open Days", 15),

                  Row(
                    children: [

                      texts("Sun", 12),
                      Checkbox(
                          activeColor: Colors.green,
                          value: sunday,
                          onChanged: (bool? value) {
                            setState(() {
                              sunday = value!;
                            });
                          }
                      ),

                      texts("Mon", 12),
                      Checkbox(
                        activeColor: Colors.green,
                          value: monday,
                          onChanged: (bool? value) {
                            setState(() {
                              monday = value!;
                            });
                          }
                      ),

                      texts("Tue", 12),
                      Checkbox(
                          activeColor: Colors.green,
                          value: tuesday,
                          onChanged: (bool? value) {
                            setState(() {
                              tuesday = value!;
                            });
                          }
                      ),

                      texts("Wed", 12),
                      Checkbox(
                          activeColor: Colors.green,
                          value: wednesday,
                          onChanged: (bool? value) {
                            setState(() {
                              wednesday = value!;
                            });
                          }
                      ),

                      texts("Thu", 12),
                      Checkbox(
                          activeColor: Colors.green,
                          value: thursday,
                          onChanged: (bool? value) {
                            setState(() {
                              thursday = value!;
                            });
                          }
                      ),

                      texts("Fri", 12),
                      Checkbox(
                          activeColor: Colors.green,
                          value: friday,
                          onChanged: (bool? value) {
                            setState(() {
                              friday = value!;
                            });
                          }
                      ),

                      texts("Sat", 12),
                      Checkbox(
                          activeColor: Colors.green,
                          value: saturday,
                          onChanged: (bool? value) {
                            setState(() {
                              saturday = value!;
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
                      style: ElevatedButton.styleFrom(

                        backgroundColor: Colors.green[100],
                        foregroundColor: Colors.green[900],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
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




  Text texts(String text, double size)
  {
    return Text(text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: const Color(0xFF000000),),
    );
  }

  TextFormField textForms(TextEditingController controller, text, String textNoValue)
  {
    return  TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: '$text*',
          labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return textNoValue;
        }
        return null;
      },
    );
  }
}




