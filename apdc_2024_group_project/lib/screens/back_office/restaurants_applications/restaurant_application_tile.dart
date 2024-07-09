import 'package:adc_group_project/services/firebase_storage.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';

class RestaurantApplicationTile extends StatelessWidget {
  const RestaurantApplicationTile({
    Key? key,
    required this.restaurantApplication,
  }) : super(key: key);

  final RestaurantApplication restaurantApplication;

  Future<void> _openPdfInBrowser(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<double> _calculateCo2EmissionEstimate(double electricityConsumption,
      double waterConsumption, double gasConsumption, int seats) async {
    double electricityCo2Emission = electricityConsumption * 0.233;
    double waterCo2Emission = waterConsumption * 0.0003;
    double gasCo2Emission = gasConsumption * 1.986;

    double co2EmissionEstimate =
        electricityCo2Emission + waterCo2Emission + gasCo2Emission;

    co2EmissionEstimate = co2EmissionEstimate / seats;

    return co2EmissionEstimate;
  }

  Future<Map<String, double>?> _showInputDialog(BuildContext context) async {
    TextEditingController electricityController = TextEditingController();
    TextEditingController waterController = TextEditingController();
    TextEditingController gasController = TextEditingController();

    return showDialog<Map<String, double>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Enter Consumption Values'),
          content: Column(
            children: [
              TextField(
                controller: electricityController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Electricity (kWh)'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: waterController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Water (liters)'),
                ),
              ),
              TextField(
                controller: gasController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Gas (m³)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'electricity': double.parse(electricityController.text),
                  'water': double.parse(waterController.text),
                  'gas': double.parse(gasController.text),
                });
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: () async {
                await DatabaseService()
                    .deleteRestaurantApplication(restaurantApplication.uid);
              },
            ),
            Expanded(
              child: ListTile(
                title: Text(restaurantApplication.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone: ${restaurantApplication.phone}'),
                    Text('Location: ${restaurantApplication.location}'),
                    Text('numberOfSeats: ${restaurantApplication.seats}'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outlined),
              onPressed: () async {
                Map<String, double>? consumptionValues =
                    await _showInputDialog(context);
                if (consumptionValues != null) {
                  double electricityConsumption =
                      consumptionValues['electricity']!;
                  double waterConsumption = consumptionValues['water']!;
                  double gasConsumption = consumptionValues['gas']!;

                  double co2EmissionEstimate =
                      await _calculateCo2EmissionEstimate(
                          electricityConsumption,
                          waterConsumption,
                          gasConsumption,
                          restaurantApplication.seats);

                  await DatabaseService().createOrOverwriteRestaurantData(
                    restaurantApplication.uid,
                    restaurantApplication.name,
                    restaurantApplication.phone,
                    restaurantApplication.address,
                    restaurantApplication.location,
                    restaurantApplication.coordinates,
                    co2EmissionEstimate,
                    restaurantApplication.seats,
                  );

                  List<String> typeNames = restaurantApplication.types;
                  await DatabaseService().addRestaurantIdToTypes(
                      typeNames, restaurantApplication.uid);

                  await DatabaseService().incrementLocation(
                      restaurantApplication.location.capitalize());

                  await DatabaseService()
                      .deleteRestaurantApplication(restaurantApplication.uid);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () async {
                String electricityPdfUrl = await StorageService()
                    .getProofDocumentUrl(
                        restaurantApplication.uid, 'electricity_.pdf');
                await _openPdfInBrowser(electricityPdfUrl);
              },
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () async {
                String gasPdfUrl = await StorageService()
                    .getProofDocumentUrl(restaurantApplication.uid, 'gas_.pdf');
                await _openPdfInBrowser(gasPdfUrl);
              },
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () async {
                String waterPdfUrl = await StorageService().getProofDocumentUrl(
                    restaurantApplication.uid, 'water_.pdf');
                await _openPdfInBrowser(waterPdfUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
