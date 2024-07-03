import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantSettingsScreen extends StatefulWidget {
  const MyRestaurantSettingsScreen({super.key});

  @override
  State<MyRestaurantSettingsScreen> createState() =>
      MyRestaurantSettingsScreenState();
}

class MyRestaurantSettingsScreenState
    extends State<MyRestaurantSettingsScreen> {
  late ScrollController scrollController;

  late bool visible;
  bool loading = true;

  @override
  void initState() {
    scrollController = ScrollController();
    getData();
    super.initState();
  }

  getData() async {
    final data = await DatabaseService().getRestaurantData();
    if (data == null) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
    } else {
      visible = data.visible;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('My Restaurant Settings'),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSpaceBetweenColumns(20),
                      Text('Activity',
                          style: Theme.of(context).textTheme.titleLarge),
                      const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 182, 141, 64)),
                      Row(
                        children: [
                          Text('Visible',
                              style: Theme.of(context).textTheme.titleMedium),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Switch(
                                  value: visible,
                                  onChanged: (bool value) {
                                    setState(() {
                                      visible = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSpaceBetweenColumns(100),
                      const Divider(
                          thickness: 2,
                          color: Color.fromARGB(255, 182, 141, 64)),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onError,
                            ),
                            child: Text(
                              'Delete Restaurant',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onError),
                            ),
                          ),
                        ),
                      ),
                      customSpaceBetweenColumns(400),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (await DatabaseService()
                                            .getRestaurantImageUrl() ==
                                        null &&
                                    visible == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Restaurant image is missing.'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if ((await DatabaseService()
                                                .hasVisibleDishes() ==
                                            false ||
                                        await DatabaseService()
                                                .hasVisibleDishes() ==
                                            null) &&
                                    visible == true) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Error'),
                                        content: const Text(
                                            'Restaurant is missing a visible dish.'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  await DatabaseService()
                                      .updateRestaurantVisibility(visible);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Save'),
                            ),
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
