

import 'package:flutter/material.dart';

class RestaurantMenu extends StatelessWidget {

  final Map<String, dynamic> info;

  const RestaurantMenu({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          Column(
            children: [
              Padding(
                padding:  const EdgeInsets.all(0),
                child: Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/menu_icon.png',
                        width: 50.0,
                        height: 50.0,),
                      const Center(
                        child: Text(
                          "M E N U",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

          Expanded(
            child: ListView.builder(
              itemCount: info['menu']!.length,
              itemBuilder: (context, index) {
                var current = info['menu']![index];
                
                return SizedBox(
                  child: ListTile(
                    leading: Image.asset(current['image']!),
                    title: Text(current['name']!),
                    subtitle: Text("${current['price']}€\n CO2e: ${current['co2']}"),
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}