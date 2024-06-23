import 'package:adc_group_project/screens/authenticate/sign_in_screen.dart';
import 'package:adc_group_project/screens/navbar_router.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adc_group_project/services/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return SignInScreen();
    } else {
      return HomeRouter();
    }
  }
}
