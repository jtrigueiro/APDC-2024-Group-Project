import 'package:adc_group_project/firebase_options.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/utils/themes/theme.dart';
import 'package:adc_group_project/wrapper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:adc_group_project/services/models/user.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
          themeMode: ThemeMode.system,
          theme: AppThemeStyle.lightTheme,
          darkTheme: AppThemeStyle.darkTheme,
          home: const Wrapper(),
          routes: {
            '/home': (context) => const Wrapper(),
          }),
    );
  }
}
