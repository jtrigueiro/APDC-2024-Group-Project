import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adc_group_project/utils/constants.dart' as constants;

class AddPromoCodePage extends StatefulWidget {
  @override
  _AddPromoCodePageState createState() => _AddPromoCodePageState();
}

class _AddPromoCodePageState extends State<AddPromoCodePage> {
  final TextEditingController _promoCodeController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();

  Future<void> _addPromoCode() async {
    String promoCode = _promoCodeController.text.trim();
    int reward = int.parse(_rewardController.text.trim());

    if (promoCode.isEmpty || reward.isNaN) {
      constants.showSnackBar(context, 'Please enter both a promo code and a reward');
      return;
    }

    if(reward < 0 || reward > 100){
      constants.showSnackBar(context, 'Please enter a reward between 0 and 100%.');
      return;
    }

    try {
      final result = await DatabaseService().getPromoCode(promoCode);
      if (result.exists) {
        constants.showSnackBar(context, 'Promo code already exists');
      }
      else {
      await DatabaseService().addPromoCode(promoCode, reward);
      constants.showSnackBar(context, 'Promo code added successfully');
      }

      _promoCodeController.clear();
      _rewardController.clear();
      return;

    } catch (error) {
      constants.showSnackBar(context, 'Failed to add promo code. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Promo Code'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _promoCodeController,
              inputFormatters: [LengthLimitingTextInputFormatter(15),],
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
            const SizedBox(height: 16),
            TextFormField(
              controller: _rewardController,
              inputFormatters: [LengthLimitingTextInputFormatter(3),
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]'),),],
              decoration: InputDecoration(
                labelText: 'Enter reward from 0 to 100%.*',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a reward';
                }
                else if(int.parse(value) < 0 || int.parse(value) > 100){
                  return 'Please enter a reward between 0 and 100%.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _addPromoCode,
              icon: const Icon(Icons.add),
              label: const Text('Add Promo Code', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
