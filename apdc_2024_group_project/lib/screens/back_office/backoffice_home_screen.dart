import 'package:adc_group_project/screens/back_office/backoffice_home/helps_and_support_list.dart';
import 'package:adc_group_project/screens/back_office/backoffice_home/promo_code_main_page.dart';
import 'package:adc_group_project/screens/back_office/restaurants_applications_screen.dart';
import 'package:flutter/material.dart';

class BackOfficeHomeScreen extends StatelessWidget {
  BackOfficeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Office'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RestaurantsApplicationsScreen(),
                  ),
                );
              },
              child: Text('Restaurants Applications'),
            ),
            SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                // Navegação para a nova tela
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SupportMessagesListScreen(), // Substitua por sua nova tela
                  ),
                );
              },
              child: Text('Helps and Support'),
            ),
            SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                // Navegação para a nova tela
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        PromoCodesHomeScreen(), // Substitua por sua nova tela
                  ),
                );
              },
              child: Text('Promo Codes Management'),
            ),
          ],
        ),
      ),
    );
  }
}
