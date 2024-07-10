import 'package:adc_group_project/screens/authenticate/sign_up_screen.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                child: kIsWeb
                    ? Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2),
                            BlendMode.dstIn,
                          ),
                          image: const AssetImage(
                            'assets/images/f2.jpg',
                          ),
                          fit: BoxFit.fill,
                        )),
                        child: Center(
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: logoSize()),
                              Container(
                                  constraints: const BoxConstraints(minWidth: 100, maxWidth: 700),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      elevation: 4,
                                      child: buildSignInWeb())),
                            ],
                          ),
                        ),
                      ) //webEnd
                    : Center(
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
                            child: Column(children: [
                              logoSize(),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.0),
                                child: Text('Log In',
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                              ),

                              Text('Enter your email and password',
                                  style: Theme.of(context).textTheme.bodySmall),

                              //form for email and password
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Form(
                                  key: _formKey,
                                  child: Column(children: [
                                    textForms(emailController, 'Email',
                                        'Enter a Email'),
                                    spaceBetweenColumns(),
                                    textFormsObscure(passwordController,
                                        'Password', 'Enter a password'),
                                  ]),
                                ),
                              ),
                              /* //TODO: Implement this
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
                      */
                              //login button
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(error,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error)),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() => loading = true);
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error = 'Wrong email or password!';
                                        });
                                      }
                                    }
                                  }
                                },
                                child: const Text('Log In'),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()),
                                    ),
                                  },
                                  style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(255, 61, 130, 20)),
                                    overlayColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 227, 237, 220)),
                                  ),
                                  child: const Text(
                                      "Don't have an account? Sign up!"),
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 11.9, 9.1, 9.1),
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
                                    margin:
                                        const EdgeInsets.fromLTRB(0, 0, 8.8, 0),
                                    child: Text(
                                      'Sign In with ',
                                      style: GoogleFonts.getFont('Open Sans',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 11.9, 0, 9.1),
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

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: InkWell(
                                  onTap: () async {
                                    await _auth.signInWithGoogle();
                                  },
                                  splashColor:
                                      Theme.of(context).colorScheme.primary,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                    child: SvgPicture.asset(
                                      "assets/vectors/grommet_iconsgoogle_x2.svg",
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
              ),
            ),
          );
  }

  Center buildSignInWeb() {
    return Center(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0, top: 30),
            child:
                Text('Log In', style: Theme.of(context).textTheme.titleLarge),
          ),

          Text('Enter your email and password',
              style: Theme.of(context).textTheme.bodySmall),

          //form for email and password
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Form(
              key: _formKey,
              child: Column(children: [
                textForms(emailController, 'Email', 'Enter a Email'),
                spaceBetweenColumns(),
                textFormsObscure(
                    passwordController, 'Password', 'Enter a password'),
              ]),
            ),
          ),
          /* //TODO: Implement this
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
                      */
          //login button
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(error,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
          ),
          ElevatedButton(
            onPressed: () async {
              {
                if (_formKey.currentState!.validate()) {
                  setState(() => loading = true);
                  dynamic result = await _auth.signInWithEmailAndPassword(
                      emailController.text, passwordController.text);
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'Wrong email or password!';
                    });
                  }
                }
              }
            },
            child: const Text('Log In'),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
            child: TextButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                ),
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 61, 130, 20)),
                overlayColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 227, 237, 220)),
              ),
              child: const Text("Don't have an account? Sign up!"),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  style: GoogleFonts.getFont('Open Sans',
                      fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ),
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

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: InkWell(
              onTap: () async {
                await _auth.signInWithGoogle();
              },
              splashColor: Theme.of(context).colorScheme.primary,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: SvgPicture.asset(
                  "assets/vectors/grommet_iconsgoogle_x2.svg",
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ]),
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
