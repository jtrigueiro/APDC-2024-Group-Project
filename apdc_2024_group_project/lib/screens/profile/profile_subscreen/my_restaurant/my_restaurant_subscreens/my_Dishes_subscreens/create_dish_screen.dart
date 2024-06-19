import 'package:flutter/material.dart';
import '../../../../../../utils/constants.dart';

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
      appBar: AppBar(
        title: const Text('Dishes Creator'),
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
                              child: const Icon(Icons.add),
                            ),
                          ),

                          spaceBetweenColumns(),
                          textForms(priceController, 'price', 'Dishes must have a price!'),

                          spaceBetweenColumns(),
                          textForms(CO2Controller, 'CO2', 'Dishes mst have a carbon footprint!'),

                          //Photos appears here

                          customSpaceBetweenColumns(50),

                          Center(
                            child: Column(
                              children: [
                                 ElevatedButton(
                                      onPressed: () {},
                                      child: const Icon(Icons.add),
                                    ),
                                Text('Add Photos', style: Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ]
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        cancelButton(context),

                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
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