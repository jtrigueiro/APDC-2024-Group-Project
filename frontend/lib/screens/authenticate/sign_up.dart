import 'package:adc_group_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late String error = '';

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //para a imagem
            Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: SizedBox(
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
                'Sign Up',
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
              margin: const EdgeInsets.fromLTRB(18.2, 20, 16.1, 50),
              child: Column(
                children: [
                  //forms
                  Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter a name' : null,
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFA8A6A7)),
                            ),
                          ),

                          //email
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFA8A6A7)),
                            ),
                          ),

                          //password
                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Enter a password'
                                : (val.length < 6
                                    ? 'Enter a password with 6 or more characters'
                                    : null),
                            obscureText: true,
                            controller: passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFA8A6A7)),
                            ),
                          ),

                          //confirm password
                          TextFormField(
                            validator: (val) => val!.isEmpty
                                ? 'Confirm your password'
                                : (val != passwordController.text
                                    ? 'Wrong confirmation password'
                                    : null),
                            obscureText: true,
                            controller: confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFA8A6A7)),
                            ),
                          ),
                        ]),
                  ),

                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 130, 196, 112)),
                      overlayColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 221, 223, 194)),
                    ),
                    child: const Text('Already have an account? Login!'),
                  ),

                  //login button
                  ElevatedButton(
                    onPressed: () async {
                      {
                        if (_formKey.currentState!.validate()) {
                          dynamic result =
                              await _auth.registerWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text);
                          if (result == null) {
                            setState(
                              () => error = 'Email not valid or already in use',
                            );
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFFFFFF)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 130, 196, 112)),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Text(
                error,
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 0, 0),
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
                      ' or Sign Up with ',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xFF000000),
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
      ),
    );
  }
}
