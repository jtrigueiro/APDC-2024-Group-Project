import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/shared/constants.dart';
import 'package:adc_group_project/shared/loading.dart';
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
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('EcoDine'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Color.fromARGB(255, 204, 178, 133)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Center(
                  heightFactor: 1.2,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        child: Image.asset("assets/images/logo-color-cut.png",
                            width: 100, height: 100, fit: BoxFit.fill),
                      ),
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      CustomSpaceBetweenColumns(20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(children: [
                            textForms(
                                nameController, 'Name', 'Enter your Name'),
                            spaceBetweenColumns(),
                            textForms(
                                emailController, 'Email', 'Enter a Email'),
                            spaceBetweenColumns(),
                            TextFormField(
                              validator: (val) => val!.isEmpty
                                  ? 'Enter a password'
                                  : (val.length < 6
                                      ? 'Enter a password with 6 or more characters'
                                      : null),
                              obscureText: true,
                              controller: passwordController,
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Password'),
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
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Confirm Password'),
                            ),
                          ]),
                        ),
                      ),
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context),
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 208, 182, 136)),
                          overlayColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 221, 223, 194)),
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
                                  error = 'Email not valid or already in use.';
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
                            color: Color.fromARGB(255, 202, 52, 76),
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
