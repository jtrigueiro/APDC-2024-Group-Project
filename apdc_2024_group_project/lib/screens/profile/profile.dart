import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Adicione aqui a lógica para fazer log out
          },
          child: Text('Log out'),
        ),
      ),
    );
  }
}
