import 'package:adc_group_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';

class RestaurantApplicationTile extends StatelessWidget {
  const RestaurantApplicationTile({
    Key? key,
    required this.restaurantApplication,
  }) : super(key: key);

  final RestaurantApplication restaurantApplication;

  // Método para abrir o PDF no navegador
  Future<void> _openPdfInBrowser(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                // Implementação para excluir a aplicação do restaurante
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
                    Text(
                      'CO2 Emission Estimate: ${restaurantApplication.co2EmissionEstimate}',
                    ),
                    Text(
                        'numberOfSeats: ${restaurantApplication.numberOfSeats}'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outlined),
              onPressed: () async {
                // Implementação para adicionar ou atualizar dados do restaurante
                await DatabaseService().addOrUpdateRestaurantData(
                  restaurantApplication.uid,
                  restaurantApplication.name,
                  restaurantApplication.phone,
                  restaurantApplication.location,
                );
                await DatabaseService()
                    .deleteRestaurantApplication(restaurantApplication.uid);
              },
            ),
            // Botão para abrir PDF de eletricidade
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () {
                _openPdfInBrowser(restaurantApplication.electricityPdfUrl);
              },
            ),
            // Botão para abrir PDF de gás
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () {
                _openPdfInBrowser(restaurantApplication.gasPdfUrl);
              },
            ),
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: () {
                _openPdfInBrowser(restaurantApplication.waterPdfUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}
