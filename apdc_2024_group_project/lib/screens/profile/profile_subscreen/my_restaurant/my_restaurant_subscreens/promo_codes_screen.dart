import 'package:flutter/material.dart';

import '../../../../../utils/constants.dart';

class PromoCodesScreen extends StatefulWidget {
  PromoCodesScreen({super.key});

  @override
  State<PromoCodesScreen> createState() => PromoCodesScreenState();
}

class PromoCodesScreenState extends State<PromoCodesScreen> {
  late ScrollController scrollController;
  late TextEditingController promoController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    scrollController = ScrollController();
    promoController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [texts('PromoCodes', 20), Icon(Icons.card_giftcard)]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceBetweenColumns(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 350,
                        child: Form(
                          key: _formKey,
                          child: textForms(promoController, 'PromoCode',
                              'Please enter a code'),
                        ),
                      ),
                      spaceBetweenColumns(),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[100],
                            foregroundColor: Colors.green[900],
                            shape: CircleBorder(),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ]),
                texts('Add your promotions code here', 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
