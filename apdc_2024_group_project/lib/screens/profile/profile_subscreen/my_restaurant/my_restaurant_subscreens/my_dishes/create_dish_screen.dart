import 'dart:io';

import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  late TextEditingController ingredientNameController;
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
    ingredientNameController = TextEditingController();
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
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Dish Creator'),
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
                reverse: true,
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
                                textForms(nameController, 'Dish name*',
                                    'Please enter a dish name'),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: textForms(
                                      descriptionController,
                                      'Description*',
                                      'Please enter a description of the dish'),
                                ),
                                textFormsDouble(
                                    priceController,
                                    'Price (in euros)*',
                                    'Dishes must have a price!'),
                                Divider(
                                  thickness: 1,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text('Ingredients*',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: DropdownMenu<Ingredient>(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          menuHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                          requestFocusOnTap: true,
                                          controller: ingredientNameController,
                                          hintText: 'Ingredient',
                                          enableFilter: true,
                                          leadingIcon: const Icon(Icons.search),
                                          onSelected: (Ingredient? value) {
                                            setState(() {
                                              selectedIngredient = value;
                                            });
                                          },
                                          dropdownMenuEntries: ingredients
                                              .map((Ingredient ingredient) {
                                            return DropdownMenuEntry<
                                                Ingredient>(
                                              value: ingredient,
                                              label: ingredient.name,
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            onPressed: () {
                                              if (selectedIngredient != null &&
                                                  ingredientWeightController
                                                      .text.isNotEmpty) {
                                                if (selectedIngredients
                                                    .contains(
                                                        selectedIngredient)) {
                                                  setState(() {
                                                    selectedIngredients.remove(
                                                        selectedIngredient);
                                                  });
                                                } // rule of three(rule of thirds) to calculate the corresponding co2
                                                int newco2 = (int.parse(
                                                            ingredientWeightController
                                                                .text) *
                                                        selectedIngredient!
                                                            .co2) ~/
                                                    selectedIngredient!.grams;
                                                selectedIngredient!.co2 =
                                                    newco2;
                                                selectedIngredient!.grams =
                                                    int.parse(
                                                        ingredientWeightController
                                                            .text);
                                                setState(() {
                                                  selectedIngredients
                                                      .add(selectedIngredient!);
                                                });
                                                ingredientWeightController
                                                    .clear();
                                                ingredientNameController
                                                    .clear();
                                              }
                                            },
                                            icon: const Icon(
                                                Icons.add_circle_outline),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: selectedIngredients.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: ListTile(
                                        tileColor: const Color.fromARGB(
                                            84, 61, 130, 20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: Text(
                                          selectedIngredients[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  'Weight: ${selectedIngredients[index].grams} grams',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall),
                                              Text(
                                                  'CO2: ${selectedIngredients[index].co2} grams',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall),
                                            ]),
                                        trailing: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedIngredients
                                                  .removeAt(index);
                                            });
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_outline),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Divider(
                                    thickness: 1,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (pickedImageFile != null)
                                      if (kIsWeb)
                                        SizedBox(
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            child: Image.network(
                                                pickedImageFile!.path),
                                          ),
                                        )
                                      else
                                        SizedBox(
                                          width: 150,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.file(
                                              File(pickedImageFile!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Column(
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              pickImage();
                                            },
                                            child: const Icon(Icons.add),
                                          ),
                                          pickedImageFile == null
                                              ? Text('Add Photo*',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(fontSize: 12))
                                              : Text('Change Photo*',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(fontSize: 12))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      if (error)
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            errorMessage,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.red,
                                ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            children: [
                              cancelButton(context),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ElevatedButton(
                                  onPressed: () async {
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
                                        errorMessage =
                                            'Please select an image!';
                                        error = true;
                                      });
                                    } else {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        final dishCo2 = selectedIngredients
                                            .fold(
                                                0,
                                                (previousValue, element) =>
                                                    previousValue +
                                                    element.co2);
                                        if (kIsWeb) {
                                          await DatabaseService().createDishWeb(
                                              nameController.text,
                                              descriptionController.text,
                                              double.parse(
                                                  priceController.text),
                                              dishCo2,
                                              selectedIngredients,
                                              await pickedImageFile!
                                                  .readAsBytes(),
                                              p.extension(
                                                  pickedImageFile!.name));
                                        } else {
                                          await DatabaseService()
                                              .createDishMobile(
                                                  nameController.text,
                                                  descriptionController.text,
                                                  double.parse(
                                                      priceController.text),
                                                  dishCo2,
                                                  selectedIngredients,
                                                  pickedImageFile!.path);
                                        }
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
