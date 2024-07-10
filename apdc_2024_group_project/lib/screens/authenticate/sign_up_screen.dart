import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  bool loading = false;

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
    return loading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Sign Up'),
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
                  decoration: kIsWeb
                      ? BoxDecoration(
                          //color: Colors.white,
                          image: DecorationImage(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2),
                              BlendMode.dstIn,
                            ),
                            image: const AssetImage(
                              'assets/images/f2.jpg',
                            ),
                            fit: BoxFit.fill,
                          ),
                        )
                      : null,
                  child: Center(
                    heightFactor: 1.1,
                    child: Column(
                      children: [
                        logoSize(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            'Welcome to EcoDine',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        const Color.fromARGB(255, 61, 130, 20)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: Form(
                            key: _formKey,
                            child: Column(children: [
                              textForms(
                                  nameController, 'Name*', 'Enter your Name'),
                              spaceBetweenColumns(),
                              textForms(
                                  emailController, 'Email*', 'Enter a Email'),
                              spaceBetweenColumns(),
                              TextFormField(
                                validator: (val) => val!.isEmpty
                                    ? 'Enter a password'
                                    : (val.length < 6
                                        ? 'Enter a password with 6 or more characters'
                                        : null),
                                obscureText: true,
                                controller: passwordController,
                                decoration: const InputDecoration().copyWith(
                                  labelText: 'Password*',
                                ),
                              ),
                              spaceBetweenColumns(),
                              TextFormField(
                                validator: (val) => val!.isEmpty
                                    ? 'Confirm your password'
                                    : (val != passwordController.text
                                        ? 'Wrong confirmation password'
                                        : null),
                                obscureText: true,
                                controller: confirmPasswordController,
                                decoration: const InputDecoration().copyWith(
                                  labelText: 'Confirm Password*',
                                ),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 5, 0, 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '* Required Fields',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color: const Color.fromARGB(255, 61, 130, 20),
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.pop(context),
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.secondary),
                            overlayColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 227, 237, 220)),
                          ),
                          child: const Text('Already have an account? Login!'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text,
                                        nameController.text);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'Email not valid or already in use.';
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              }
                            }
                          },
                          child: const Text('Sign Up'),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text(
                            error,
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: const Color.fromARGB(255, 202, 52, 76),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Padding logoSize() {
    if (kIsWeb) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const Image(
              image: AssetImage(
            "assets/images/ecodine-high-resolution-logo-transparent.png",
          )),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: const Image(
              image: AssetImage(
            "assets/images/ecodine-high-resolution-logo-transparent.png",
          )),
        ),
      );
    }
  }
}
