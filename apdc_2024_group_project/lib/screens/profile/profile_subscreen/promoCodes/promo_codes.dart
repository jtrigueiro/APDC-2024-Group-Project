import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromoCodesScreen extends StatefulWidget {
  PromoCodesScreen({Key? key}) : super(key: key);

  @override
  _PromoCodesScreenState createState() => _PromoCodesScreenState();
}

class _PromoCodesScreenState extends State<PromoCodesScreen> {
  final TextEditingController _promoCodeController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _redeemPromoCode() async {
    String promoCode = _promoCodeController.text.trim();

    if (promoCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a promotional code')),
      );
      return;
    }

    try {
      DocumentSnapshot promoCodeDoc =
          await _firestore.collection('promo_codes').doc(promoCode).get();

      if (promoCodeDoc.exists) {
        Map<String, dynamic> promoData =
            promoCodeDoc.data() as Map<String, dynamic>;
        String reward = promoData['reward'];

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
      resizeToAvoidBottomInset: false, // Evita que o teclado cause overflow
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: Text(
          'Promo Codes',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[100]!, Colors.amber[800]!],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _promoCodeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your promo code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Enter a promo code to redeem rewards!',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                onPressed: _redeemPromoCode,
                icon: Icon(Icons.add, size: 24),
                label: Text('Redeem Code', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
