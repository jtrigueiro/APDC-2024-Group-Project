import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_dish_screen.dart';

class MyDishesScreen extends StatefulWidget {
  MyDishesScreen({super.key});


  @override
  State<MyDishesScreen> createState() => MyDishesScreenState();
}

class MyDishesScreenState extends State<MyDishesScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: texts('My Dishes', 20),
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
          child: Column(
            children: [

              SizedBox(height: 25),
              texts('Add Dishes',20),
              //dishes se tem
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push( MaterialPageRoute(
                      builder: (context) => CreateDishesScreen(),),
                    );

                  },
                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.green[100],
                    foregroundColor: Colors.green[900],
                    shape: CircleBorder(),
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),),
      ),
    );
  }



  Text texts(String text, double size)
  {
    return Text(text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: const Color(0xFF000000),),
    );
  }
}