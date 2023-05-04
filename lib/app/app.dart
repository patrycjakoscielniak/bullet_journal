import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../auth/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('pl'), // Polish
      ],
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
        appBarTheme: AppBarTheme(
          centerTitle: true,
          toolbarTextStyle: GoogleFonts.greatVibes(),
          titleTextStyle: GoogleFonts.greatVibes(
              textStyle: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w100,
          )),
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
