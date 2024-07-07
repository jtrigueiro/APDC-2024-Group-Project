import 'package:adc_group_project/screens/back_office/promo_codes/active_promocodes_list.dart';
import 'package:adc_group_project/screens/back_office/promo_codes/promo_code_add.dart';
import 'package:flutter/material.dart';

class PromoCodesHomeScreen extends StatefulWidget {
  @override
  _PromoCodesHomeScreen createState() => _PromoCodesHomeScreen();
}

class _PromoCodesHomeScreen extends State<PromoCodesHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotion Codes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPromoCodePage(),
                  ),
                );
              },
              child: Text('Add Promo Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivePromoCodesPage(),
                  ),
                );
              },
              child: Text('List Active Promo Codes'),
            ),
          ],
        ),
      ),
    );
  }
}
