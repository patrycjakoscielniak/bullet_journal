import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/auth_gate.dart';

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
        textTheme: TextTheme(
            bodyMedium: GoogleFonts.indieFlower(),
            titleLarge: GoogleFonts.indieFlower(),
            labelLarge: GoogleFonts.indieFlower()),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarTextStyle: GoogleFonts.greatVibes(),
          titleTextStyle: GoogleFonts.greatVibes(
              textStyle: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w100,
          )),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 160, 117, 217),
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
