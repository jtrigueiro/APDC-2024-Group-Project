import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Scrollbar(
              controller: scrollController,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildSectionTitle('Activity'),
                  Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.primary),
                  SwitchListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Visible',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  )),
                    ),
                    value: visible,
                    activeColor: Theme.of(context).colorScheme.onBackground,
                    onChanged: (bool value) {
                      setState(() {
                        visible = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(
                            thickness: 1,
                            color: Theme.of(context).colorScheme.secondary),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            await DatabaseService().deleteRestaurant();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            setState(() {
                              loading = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError,
                          ),
                          child: const Text(
                            'Delete Restaurant',
                          ),
                        ),
                        Divider(
                            thickness: 1,
                            color: Theme.of(context).colorScheme.secondary),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (await DatabaseService()
                                        .getRestaurantImageUrl() ==
                                    null &&
                                visible == true) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error',
                                        textAlign: TextAlign.center),
                                    content: Text(
                                        'Restaurant image is missing.',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
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
                                    title: const Text('Error',
                                        textAlign: TextAlign.center),
                                    content: Text(
                                        'Restaurant is missing a visible dish.',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 17));
  }
}
