import 'package:adc_group_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  late ScrollController scrollController;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late String error = '';

  @override
  void initState() {
    scrollController = ScrollController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
        surfaceTintColor: Colors.green,
        shadowColor: Colors.green[400],
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
          child: Container(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                                  () => error =
                                      'Email not valid or already in use.',
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
