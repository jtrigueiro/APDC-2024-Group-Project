import 'package:adc_group_project/services/auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text('Log out'),
        ),
      ),
    );
  }
}
