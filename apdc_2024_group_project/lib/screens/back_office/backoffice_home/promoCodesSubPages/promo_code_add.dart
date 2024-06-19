import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPromoCodePage extends StatefulWidget {
  @override
  _AddPromoCodePageState createState() => _AddPromoCodePageState();
}

class _AddPromoCodePageState extends State<AddPromoCodePage> {
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _addPromoCode() async {
    String promoCode = _promoCodeController.text.trim();
    String reward = _rewardController.text.trim();

    if (promoCode.isEmpty || reward.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both a promo code and a reward')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Promo Code'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _promoCodeController,
              decoration: InputDecoration(
                labelText: 'Enter PromoCode*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a promo code';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _rewardController,
              decoration: InputDecoration(
                labelText: 'Enter reward*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a reward';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _addPromoCode,
              icon: Icon(Icons.add),
              label: Text('Add Promo Code', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
