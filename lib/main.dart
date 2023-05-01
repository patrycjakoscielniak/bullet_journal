import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bullet_journal/firebase_options.dart';

import 'auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 160, 117, 217),
          onPrimary: Colors.white,
          secondary: Colors.cyan,
          onSecondary: Colors.white,
          error: Color.fromARGB(255, 221, 55, 9),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.blueGrey,
          surface: Colors.white,
          onSurface: Colors.blueGrey,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: Color.fromARGB(255, 160, 117, 217)),
      ),
      home: const AuthGate(),
    );
  }
}
