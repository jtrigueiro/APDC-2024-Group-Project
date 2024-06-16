import 'package:flutter/material.dart';
import '../../../../../../shared/constants.dart';

class CreateDishesScreen extends StatefulWidget {
  CreateDishesScreen({super.key});


  @override
  State<CreateDishesScreen> createState() => CreateDishesScreenState();
}

class CreateDishesScreenState extends State<CreateDishesScreen> {
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController CO2Controller;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    priceController = TextEditingController();
    CO2Controller = TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: texts('Dish Creator', 20),
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          spaceBetweenColumns(),
                          textForms(nameController, 'Dish Name', 'Please enter a dish name'),

                          spaceBetweenColumns(),

                          textForms(nameController, 'Ingredients //wrong', 'Please enter a ingredients'),

                          spaceBetweenColumns(),
                          SizedBox(

                            child:ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(

                                backgroundColor: Colors.green[100],
                                foregroundColor: Colors.green[900],
                                shape: CircleBorder(),
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),

                          spaceBetweenColumns(),
                          textForms(priceController, 'price', 'Dishes must have a price!'),

                          spaceBetweenColumns(),
                          textForms(CO2Controller, 'CO2', 'Dishes mst have a carbon footprint!'),

                          //Photos appears here

                          CustomSpaceBetweenColumns(50),
                          Center(
                            child: Column(
                              children: [

                                SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[100],
                                        foregroundColor: Colors.green[900],
                                        shape: CircleBorder(),
                                      ),
                                      child: const Icon(Icons.add),
                                    ),
                                ),

                                texts('Add Photos', 15),
                              ],
                            ),
                          ),
                        ]
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomRight,
                  child:
                  Row(
                    children: [
                      cancelButton(context),

                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                          }
                          },
                        style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.green[100],
                          foregroundColor: Colors.green[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
                spaceBetweenColumns(),
              ]
          ),
        ),
      ),
    );
  }






}