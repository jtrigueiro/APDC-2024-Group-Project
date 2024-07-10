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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              workButton('Add Promo Code', ontapAddPromo()),
              workButton('List Active Promotion Codes', ontapListPromo()),
            ]),
      ),
    );
  }

  Function ontapListPromo() {
    return () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ActivePromoCodesPage(),
        ),
      );
    };
  }

  Function ontapAddPromo() {
    return () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddPromoCodePage(),
        ),
      );
    };
  }

  ElevatedButton workButton(String text, Function ontap) {
    return ElevatedButton(
      style: const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
      onPressed: () {
        ontap();
      },
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}
