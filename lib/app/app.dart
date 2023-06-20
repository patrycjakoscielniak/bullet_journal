import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final appPurple = const Color.fromARGB(255, 160, 117, 217);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: appPurple,
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white,
          error: const Color.fromARGB(255, 221, 55, 9),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.blueGrey,
          surface: Colors.white,
          onSurface: Colors.blueGrey,
        ),
        textTheme: TextTheme(
            bodyMedium: GoogleFonts.indieFlower(),
            titleLarge: GoogleFonts.indieFlower(),
            labelLarge: GoogleFonts.amaticSc(
                textStyle: const TextStyle(
                    fontSize: 23, fontWeight: FontWeight.w600))),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: appPurple,
          centerTitle: true,
          toolbarTextStyle: GoogleFonts.greatVibes(),
          titleTextStyle: GoogleFonts.greatVibes(
              textStyle: TextStyle(
            color: appPurple,
            fontSize: 30,
            fontWeight: FontWeight.w100,
          )),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.amaticSc(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 21)),
            hintStyle: GoogleFonts.amaticSc(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 21))),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: appPurple, foregroundColor: Colors.white),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.blueGrey,
            selectedItemColor: appPurple),
      ),
      home: const AuthGate(),
    );
  }
}
