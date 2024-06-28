import 'package:flutter/material.dart';

class RestaurantInfo extends StatelessWidget {

  const RestaurantInfo({required this.info, super.key});

  final Map<String, dynamic> info;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
              color: const Color.fromRGBO(52, 168, 83, 0.23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "${info['name']!} - ${info['address']}\n", //${info['price']!}\n${info['tag']!}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        
                        const Column(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 20,),

                            Text(
                              "rating", // "${info['rating']!}",
                              style: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset('assets/images/restaurant1.png',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitWidth,
                      
                    ),
                  ),

                  Row(
                    children: [
                      IconButton(onPressed: null, icon: const Icon(Icons.psychology_alt_outlined)),

                      Text(
                        "CO2", //"${info['co2']!} CO2e*",
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        iconSize: 20,
                        onPressed: () {
                          //add to favorites
                        },
                      )
                    ],
                  ),

                  const Text(
                    "*average per dish",
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              )
              ),
        ],
      ),
    );
  
  }

}