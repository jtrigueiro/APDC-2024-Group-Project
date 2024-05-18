import 'package:adc_group_project/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adc_group_project/models/user.dart';
import 'package:adc_group_project/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return const SignIn();
    } else {
      return HomeScreen();
    }
  }
}
