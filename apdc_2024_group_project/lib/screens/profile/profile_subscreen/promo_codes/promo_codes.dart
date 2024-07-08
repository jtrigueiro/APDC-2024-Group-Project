import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromoCodesPage extends StatefulWidget {
  PromoCodesPage({Key? key}) : super(key: key);

  @override
  _PromoCodesPageState createState() => _PromoCodesPageState();
}

class _PromoCodesPageState extends State<PromoCodesPage> {
  final TextEditingController _promoCodeController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  Future<void> _redeemPromoCode() async {
    String promoCode = _promoCodeController.text.trim();

    if (promoCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a promotional code')),
      );
      return;
    }

    try {
      DocumentSnapshot promoCodeDoc = await _dbService.getPromoCode(promoCode);

      if (promoCodeDoc.exists) {
        Map<String, dynamic> promoData =
            promoCodeDoc.data() as Map<String, dynamic>;
        String reward = promoData['reward'];

        await _dbService.redeemPromoCode(promoCode, reward);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Promo code redeemed! Reward: $reward')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid promotional code')),
        );
      }
    } catch (e) {
      print('Error redeeming promo code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error redeeming promo code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Promotion Codes',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _promoCodeController,
                decoration:
                    const InputDecoration().copyWith(labelText: 'Enter a promotion code*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a promo code';
                  }
                  return null;
                },
              ),
              /*Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  'Enter a promotion code to redeem rewards!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey[600], fontSize: 13.5)),
                ),*/

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ElevatedButton.icon(
                    onPressed: _redeemPromoCode,
                    icon: const Icon(Icons.add),
                    label:  const Text('Redeem Code')),
              ),
              SizedBox(
                  height: MediaQuery.of(context)
                      .viewInsets
                      .bottom), // Espaço para evitar que o teclado cubra o botão

            ],
          ),
        ),
      ),
    );
  }
}
