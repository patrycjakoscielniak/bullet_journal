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
          secondary: Colors.cyan,
          onSecondary: Colors.white,
          error: const Color.fromARGB(255, 221, 55, 9),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.blueGrey,
          surface: Colors.white,
          onSurface: Colors.blueGrey,
        ),
        textTheme: TextTheme(
            bodyMedium: GoogleFonts.courgette(),
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
