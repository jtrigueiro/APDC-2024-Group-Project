import 'package:adc_group_project/screens/authenticate/sign_up_screen.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late ScrollController scrollController;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late String error = '';
  bool loading = false;

  @override
  void initState() {
    scrollController = ScrollController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            body: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Center(
                  heightFactor: 1.2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            child: SvgPicture.asset("assets/vectors/logo.svg",
                                width: 80, height: 80, fit: BoxFit.fill),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'EcoDine',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              Text(
                                'Eat while healping the world',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 50),
                      Text('Sign In',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      Text('Enter your email and password',
                          style: Theme.of(context).textTheme.bodySmall),

                      //form for email and password
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(children: [
                            textForms(
                                emailController, 'Email', 'Enter a Email'),
                            spaceBetweenColumns(),
                            textFormsObscure(passwordController, 'Password',
                                'Enter a password'),
                          ]),
                        ),
                      ),

                      TextButton(
                        onPressed: () => {},
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 208, 182, 136)),
                          overlayColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 221, 223, 194)),
                        ),
                        child: const Text('Forgot Password?'),
                      ),

                      //login button
                      ElevatedButton(
                        onPressed: () async {
                          {
                            if (_formKey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Wrong email or password.';
                                });
                              }
                            }
                          }
                        },
                        child: Text('Log In'),
                      ),

                      customSpaceBetweenColumns(50),
                      TextButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()),
                          ),
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 208, 182, 136)),
                          overlayColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 221, 223, 194)),
                        ),
                        child: const Text("Don't have an account? Sign up!"),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.fromLTRB(0, 11.9, 9.1, 9.1),
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
                                color: const Color.fromARGB(255, 208, 182, 136),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.fromLTRB(0, 11.9, 0, 9.1),
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
                      spaceBetweenColumns(),

                      InkWell(
                        onTap: () {
                          _auth.signInWithGoogle();
                        },
                        splashColor: Color.fromARGB(255, 208, 182, 136),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          child: SvgPicture.asset(
                            "assets/vectors/grommet_iconsgoogle_x2.svg",
                            width: 70,
                            height: 60,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                ]
                  ),
                ),
              ),
    ),
          );
  }
}
