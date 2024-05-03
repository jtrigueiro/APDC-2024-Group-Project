import 'package:adc_handson_session/resources/application/list_user_permissions.dart';
import 'package:flutter/material.dart';
import 'package:adc_handson_session/resources/application/auth.dart';

class ListUserPermissionsScreen extends StatefulWidget {
  const ListUserPermissionsScreen({super.key});

  @override
  State<ListUserPermissionsScreen> createState() =>
      _ListUserPermissionsScreen();
}

class _ListUserPermissionsScreen extends State<ListUserPermissionsScreen> {
  late String userPermissions;
  late String userToken;
  @override
  void initState() {
    userPermissions = '';
    userToken = '';
    super.initState();
    registerButtonPressed();
  }

  Future<void> registerButtonPressed() async {
    String permissions = await ListUserPermissions.listUserPermissions();
    String token = await Authentication.getToken();
    setState(() {
      userPermissions = permissions;
      userToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our First App - View Permissions Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Token: $userToken'),
            Text('Permissions: $userPermissions'),
          ],
        ),
      ),
    );
  }
}
