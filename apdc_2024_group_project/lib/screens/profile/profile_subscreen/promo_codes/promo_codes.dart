import 'package:adc_group_project/services/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class PromoCodesPage extends StatefulWidget {
  PromoCodesPage({Key? key}) : super(key: key);

  @override
  _PromoCodesPageState createState() => _PromoCodesPageState();
}

class _PromoCodesPageState extends State<PromoCodesPage> {
  final TextEditingController _promoCodeController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  bool redeeming = false;
  DateTime? lastRedeemed;
  int redeemTimeOut = 1;

  @override
  initState() {
    SharedPreferences.getInstance().then((prefs) {
      lastRedeemed = prefs.getString('lastRedeemed') != null ? DateTime.parse(prefs.getString('lastRedeemed')!) : null;
      if(lastRedeemed != null){
        Duration difference = DateTime.now().difference(lastRedeemed!);
        redeemTimeOut = (difference < const Duration(seconds: 3600) ? prefs.getInt('redeemTimeOut')! : 1);
      }
      else{
        redeemTimeOut = 1;
      }
    });
    super.initState();
  }

  Future<void> _redeemPromoCode() async {
    setState(() {
      redeeming = true;
    });

    String promoCode = _promoCodeController.text.trim();

    if (promoCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a promotional code'),
        duration: Duration(seconds: 1),
      ));
      return;
    }

    if(lastRedeemed != null){
      Duration difference = DateTime.now().difference(lastRedeemed!);
      if(difference < Duration(seconds: redeemTimeOut)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You can try redeeming a promo code again in ${Duration(seconds: redeemTimeOut).inSeconds - difference.inSeconds} seconds'),
          duration: const Duration(seconds: 1),),
        );
        setState(() {
          redeeming = false;
        });
        return;
      }
    }

    try {
      DocumentSnapshot promoCodeDoc = await _dbService.getPromoCode(promoCode);

      if (promoCodeDoc.exists) {
        Map<String, dynamic> promoData =
            promoCodeDoc.data() as Map<String, dynamic>;
        String reward = promoData['reward'];

        await _dbService.redeemPromoCode(promoCode, reward);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Promo code redeemed! Reward: $reward'),
          duration: const Duration(seconds: 1),),
        );
      } else {
        redeemTimeOut = math.min(redeemTimeOut * 2, 3600);
        lastRedeemed = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid promotional code'),
          duration: Duration(seconds: 1),),
        );
      }
    } catch (e) {
      print('Error redeeming promo code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error redeeming promo code',),
        duration: Duration(seconds: 1),),
      );
    } finally {print('before shared pref');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('redeemTimeOut', redeemTimeOut);
      await prefs.setString('lastRedeemed', lastRedeemed.toString());

      setState(() {
        redeeming = false;
      });
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
                inputFormatters: [LengthLimitingTextInputFormatter(10),],
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

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: redeeming ? const CircularProgressIndicator() : ElevatedButton.icon(
                    onPressed: _redeemPromoCode,
                    icon: const Icon(Icons.add),
                    label:  const Text('Redeem Code')),
              ),
              SizedBox(
                  height: MediaQuery.of(context)
                      .viewInsets
                      .bottom),

            ],
          ),
        ),
      ),
    );
  }
}
