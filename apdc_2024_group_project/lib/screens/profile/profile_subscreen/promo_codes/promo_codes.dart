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
        title: Text(
          'Promo Codes',
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 117, 85, 18)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _promoCodeController,
                decoration:
                    InputDecoration().copyWith(labelText: 'Enter Promocode*'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a promo code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Enter a promo code to redeem rewards!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                  onPressed: _redeemPromoCode,
                  icon: Icon(Icons.add, size: 24),
                  label: Text('Redeem Code', style: TextStyle(fontSize: 16))),
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
