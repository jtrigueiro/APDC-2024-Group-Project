import 'package:flutter/material.dart';

class RestaurantInfo extends StatelessWidget {

  const RestaurantInfo({required this.info, super.key});

  final Map<String, dynamic> info;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          Padding(padding: const EdgeInsets.all(0),
            child: Container(
              color: const Color.fromRGBO(52, 168, 83, 0.23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "${info['name']!} - ${info['location']}\n${info['price']!}\n${info['tag']!}",
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        
                        Column(
                          children: [
                            Image.asset('assets/images/star_icon.png',
                              width: 20,
                              height: 20,
                            ),

                            Text(
                              "${info['rating']!}",
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
                    child: Image.asset(info['image']!,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitWidth,
                      
                    ),
                  ),

                  Row(
                    children: [
                      Image.asset('assets/images/image_2_icon.png',
                        width: 20,
                        height: 20,
                      ),

                      Text(
                        "${info['co2']!} CO2e*",
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      IconButton(
                        icon: Image.asset('assets/images/heart_empty_icon.png'),
                        iconSize: 50,
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
          ),
        ],
      ),
    );
  
  }

}