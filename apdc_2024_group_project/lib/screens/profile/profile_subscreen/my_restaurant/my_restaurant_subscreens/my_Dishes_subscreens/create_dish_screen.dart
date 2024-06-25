import 'dart:io';
import 'dart:math';

import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../utils/constants.dart';

class CreateDishesScreen extends StatefulWidget {
  CreateDishesScreen({super.key});

  @override
  State<CreateDishesScreen> createState() => CreateDishesScreenState();
}

class CreateDishesScreenState extends State<CreateDishesScreen> {
  late ScrollController scrollController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController co2Controller;
  late TextEditingController ingredientWeightController;
  Ingredient? selectedIngredient;
  final _formKey = GlobalKey<FormState>();
  late List<Ingredient> ingredients;
  bool loading = true;
  late List<Ingredient> selectedIngredients = [];
  XFile? pickedImageFile;
  late String errorMessage;
  bool error = false;

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    co2Controller = TextEditingController();
    ingredientWeightController = TextEditingController();
    getIngredients();

    super.initState();
  }

  getIngredients() async {
    ingredients = await DatabaseService().getAllIngredients();
    if (ingredients.isNotEmpty) {
      setState(() {
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    }
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Dish Creator'),
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
                                textForms(nameController, 'Name*',
                                    'Please enter a dish name'),
                                spaceBetweenColumns(),
                                textForms(descriptionController, 'Description*',
                                    'Please enter a description of the dish'),
                                spaceBetweenColumns(),
                                // TODO: make this field only accept doubles - jose
                                textForms(priceController, 'Price (in euros)*',
                                    'Dishes must have a price!'),
                                spaceBetweenColumns(),
                                const Text('Ingredients*:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DropdownMenu<Ingredient>(
                                        requestFocusOnTap: true,
                                        hintText: 'Select Ingredient',
                                        enableFilter: true,
                                        leadingIcon: const Icon(Icons.search),
                                        // inputDecorationTheme: ,
                                        onSelected: (Ingredient? value) {
                                          setState(() {
                                            selectedIngredient = value;
                                          });
                                        },
                                        dropdownMenuEntries: ingredients
                                            .map((Ingredient ingredient) {
                                          return DropdownMenuEntry<Ingredient>(
                                            value: ingredient,
                                            label: ingredient.name,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                    Expanded(
                                      child: TextFormField(
                                        controller: ingredientWeightController,
                                        decoration: const InputDecoration(
                                          labelText: 'Weight (grams)',
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (selectedIngredient != null &&
                                            ingredientWeightController
                                                .text.isNotEmpty) {
                                          if (selectedIngredients
                                              .contains(selectedIngredient)) {
                                            setState(() {
                                              selectedIngredients
                                                  .remove(selectedIngredient);
                                            });
                                          } // rule of three(rule of thirds) to calculate the corresponding co2
                                          int newco2 = (int.parse(
                                                      ingredientWeightController
                                                          .text) *
                                                  selectedIngredient!.co2) ~/
                                              selectedIngredient!.grams;
                                          selectedIngredient!.co2 = newco2;
                                          selectedIngredient!.grams = int.parse(
                                              ingredientWeightController.text);
                                          setState(() {
                                            selectedIngredients
                                                .add(selectedIngredient!);
                                          });
                                        }
                                      },
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                    ),
                                  ],
                                ),
                                spaceBetweenColumns(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: selectedIngredients.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title:
                                          Text(selectedIngredients[index].name),
                                      subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Weight: ${selectedIngredients[index].grams} grams'),
                                            Text(
                                                'CO2: ${selectedIngredients[index].co2} grams'),
                                          ]),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedIngredients.removeAt(index);
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.remove_circle_outline),
                                      ),
                                    );
                                  },
                                ),
                                spaceBetweenColumns(),
                                const Divider(
                                  height: 20,
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                spaceBetweenColumns(),
                                Center(
                                  child: Column(
                                    children: [
                                      if (pickedImageFile != null)
                                        Container(
                                          child: Image.file(
                                            File(pickedImageFile!.path),
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ElevatedButton(
                                        onPressed: () {
                                          pickImage();
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                      Text('Add Photo*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      if (error)
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              cancelButton(context),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pop(context);
                                  }
                                  if (selectedIngredients.isEmpty &&
                                      pickedImageFile == null) {
                                    setState(() {
                                      errorMessage =
                                          'Please select at least one ingredient and choose an image!';
                                      error = true;
                                    });
                                  } else if (selectedIngredients.isEmpty) {
                                    setState(() {
                                      errorMessage =
                                          'Please select at least one ingredient!';
                                      error = true;
                                    });
                                  } else if (pickedImageFile == null) {
                                    setState(() {
                                      errorMessage = 'Please select an image!';
                                      error = true;
                                    });
                                  } else {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      await DatabaseService().addOrUpdateDish(
                                          nameController.text,
                                          descriptionController.text,
                                          double.parse(priceController.text),
                                          selectedIngredients,
                                          pickedImageFile!.path);
                                      Navigator.pop(context);
                                      setState(() {
                                        loading = false;
                                      });
                                    } else {
                                      setState(() {
                                        errorMessage =
                                            'Please fill in all the required fields!';
                                        error = true;
                                      });
                                    }
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceBetweenColumns(),
                    ]),
              ),
            ),
          );
  }
}
