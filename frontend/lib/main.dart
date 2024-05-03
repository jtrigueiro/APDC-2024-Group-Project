import 'package:flutter/material.dart';

import 'resources/data/users_local_storage.dart';
import 'resources/presentation/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Uncomment later on to test the Local DB
  // Test it on Android! Doesn't work on the browser
  void accessDB() {
    LocalDB db = LocalDB(localDatabaseName);
    db.initDB();
    db.countUsers();
    db.listAllTables();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ADC First App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Colors.black),
          textTheme: const TextTheme(
            titleMedium: TextStyle(color: Colors.black),
          ),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Our First App - Login Screen'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                  child: const FlutterLogo(
                    size: 40,
                  ),
                ),
                const LoginScreen(),
                // TODO: uncomment to test the Local DB (Android)
                //FloatingActionButton(onPressed: accessDB),
              ],
            ))));
  }
}
