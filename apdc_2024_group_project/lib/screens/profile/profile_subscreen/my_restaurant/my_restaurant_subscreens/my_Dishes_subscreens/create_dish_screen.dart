import 'package:adc_group_project/services/database.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late TextEditingController CO2Controller;
  late TextEditingController ingredientWeightController;
  Ingredient? selectedIngredient;
  final _formKey = GlobalKey<FormState>();
  late List<Ingredient> ingredients;
  bool loading = true;
  late List<Ingredient> selectedIngredients = [];

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    CO2Controller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
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

                                textForms(nameController, 'Dish Name',
                                    'Please enter a dish name'),

                                spaceBetweenColumns(),

                                textForms(
                                    descriptionController,
                                    'Dish description',
                                    'Please enter a description of the dish'),

                                spaceBetweenColumns(),

                                textForms(priceController, 'price',
                                    'Dishes must have a price!'),

                                spaceBetweenColumns(),

                                /*DropdownButtonFormField<Ingredient>(
                                  value: selectedIngredient,
                                  items:
                                      ingredients.map((Ingredient ingredient) {
                                    return DropdownMenuItem<Ingredient>(
                                      value: ingredient,
                                      child: Text(ingredient.name),
                                    );
                                  }).toList(),
                                  onChanged: (Ingredient? newValue) {
                                    setState(() {
                                      selectedIngredient = newValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Select Ingredient',
                                    border: OutlineInputBorder(),
                                  ),
                                ),*/
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
                                          int newco2 = (int.parse(
                                                      ingredientWeightController
                                                          .text) *
                                                  selectedIngredient!.co2) ~/
                                              selectedIngredient!.grams;
                                          selectedIngredient!.co2 = newco2;
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
                                      subtitle: Text(
                                          'CO2: ${selectedIngredients[index].co2} grams'),
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
                                //Photos appears here

                                customSpaceBetweenColumns(50),

                                Center(
                                  child: Column(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Icon(Icons.add),
                                      ),
                                      Text('Add Photos',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                              ]),
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
                    ]),
              ),
            ),
          );
  }
}
