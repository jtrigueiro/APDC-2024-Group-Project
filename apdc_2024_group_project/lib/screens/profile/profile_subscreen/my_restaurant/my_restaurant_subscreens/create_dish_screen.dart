import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../utils.dart';

class CreateDishesScreen extends StatefulWidget {
  CreateDishesScreen({super.key});


  @override
  State<CreateDishesScreen> createState() => CreateDishesScreenState();
}

class CreateDishesScreenState extends State<CreateDishesScreen> {
  late ScrollController scrollController;
  late TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: Utils.texts('My Dishes', 20),
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
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Utils.textForms(nameController, 'Dish Name', 'Please enter a dish name'),

                        SizedBox(height: 20),
                        Utils.textForms(nameController, 'Ingredients //wrong', 'Please enter a ingredients'),

                      ]
                  ),
                ),

                SizedBox(height: 20),
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
              ]
          ),
        ),
      ),
    );
  }






}