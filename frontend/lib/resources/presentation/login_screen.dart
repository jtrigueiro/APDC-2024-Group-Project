import 'package:adc_handson_session/resources/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';
import 'package:adc_handson_session/resources/presentation/main_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  void logInButtonPressed(String username, String password) async {
    if (await Authentication.loginUser(username, password)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // Wrong credentials
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Wrong username or password."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              labelText: 'User Name',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(90.0),
              ),
              labelText: 'Password',
            ),
          ),
        ),
        Container(
            height: 80,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Log In'),
              onPressed: () => logInButtonPressed(
                  usernameController.text, passwordController.text),
            )),
        Container(
            height: 80,
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Register'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              ),
            )),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          child: const Text('Forgot Password?'),
        ),
      ],
    );
  }
}
