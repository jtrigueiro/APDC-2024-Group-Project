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
      appBar: AppBar(
        title: const Text('My Restaurant'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 117, 85, 18)),
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
                        width: MediaQuery.of(context).size.width *0.7,
                        child: Form(
                          key: _formKey,
                          child: textForms(promoController, 'PromoCode',
                              'Please enter a code'),
                        ),
                      ),

                      spaceBetweenColumns(),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ]),
                spaceBetweenColumns(),
                Text('Add your promotions code here', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
