import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
    const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}


class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            //para a imagem
            Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child:
              SizedBox(
                    width: 70,
                    height: 70,
                    child: SvgPicture.asset(
                      "assets/vectors/logo.svg",
              ),
              ),
            ),
            //text 
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 3.7, 0),
              child: Text(
                'Sign In',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: const Color(0xFF000000),
                ),
              ),
            ),

            //forms
            Container(
              margin: const EdgeInsets.fromLTRB(18.2, 0, 16.1,50),
              child: Column(
                children: [
                  Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Enter your email and password',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: const Color(0xFFA8A6A7),
                            ),
                          ),
                        ),
                      ),

                 //form for email and password
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        //email
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(                          
                          labelText: 'Email',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Color(0xFFA8A6A7)),
                          
                          ),
                        ),

                      //password
                        TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(                          
                          labelText: 'Password',
                          labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Color(0xFFA8A6A7)),
                          ),
                        ),
                      ]
                    ),  
                  ),

                  TextButton(
                   
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 130, 196, 112)),
                      overlayColor: MaterialStateProperty.all(const Color.fromARGB(255, 221, 223, 194)),
                    ),
                    child: const Text('Forgot Password?'),
                  ),
                
                 //login button
                  ElevatedButton(
                    onPressed: () { },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 130, 196, 112)),
                      ),
                    child: const Text('Log In'),
                  ),
                ],
              ),
            ),
            
          
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account? ',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                      
                      children: [
                        //on tap??
                        TextSpan( 
                          text: ' Sign up',
                          style: GoogleFonts.getFont(
                            'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            height: 1.3,
                            color: Color(0xFF34A853),
                            decorationColor: Color(0xFF34A853),

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              

                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //line entre o sign in with
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 11.9, 9.1, 9.1),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFA8A6A7),
                            ),
                            child: Container(
                              height: 1,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 8.8, 0),
                        child: Text(
                          'Sign In with ',
                          style: GoogleFonts.getFont(
                            'Nunito',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color:const  Color(0xFF000000),
                          ),
                        ),
                      ),
                      //line entre o sign in with
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 11.9, 0, 9.1),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFA8A6A7),
                            ),
                            child: Container(
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: SizedBox(
                    width: 57.5,
                    height: 58.4,
                    child: SvgPicture.asset(
                      'assets/vectors/grommet_iconsgoogle_x2.svg',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      
    );
  }
}