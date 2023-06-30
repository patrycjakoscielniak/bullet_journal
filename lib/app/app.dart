import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bullet_journal/app/core/injection_container.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/add/cubit/add_event_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/details/cubit/event_details_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/add_item_page/cubit/add_item_page_cubit.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/cubit/wishlist_page_cubit.dart';
import '../auth/auth_gate.dart';
import 'core/global_variables.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<PlannerCubit>()),
        BlocProvider(create: (context) => getIt<EditEventCubit>()),
        BlocProvider(create: (context) => getIt<EventDetailsCubit>()),
        BlocProvider(create: (context) => getIt<AddEventCubit>()),
        BlocProvider(create: (context) => getIt<VisionBoardCubit>()),
        BlocProvider(create: (context) => getIt<WishlistPageCubit>()),
        BlocProvider(create: (context) => getIt<AddItemPageCubit>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: appPurple,
            onPrimary: Colors.white,
            secondary: appGrey,
            onSecondary: Colors.white,
            error: errorColor,
            onError: Colors.white,
            background: Colors.white,
            onBackground: appGrey,
            surface: Colors.white,
            onSurface: appGrey,
          ),
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.gruppo(fontSize: 15),
              titleLarge: GoogleFonts.amaticSc(),
              labelLarge: GoogleFonts.amaticSc(
                  textStyle: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w600))),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: appGrey,
            centerTitle: true,
            toolbarTextStyle: GoogleFonts.greatVibes(),
            titleTextStyle: GoogleFonts.greatVibes(
                textStyle: const TextStyle(
              color: appPurple,
              fontSize: 30,
              fontWeight: FontWeight.w100,
            )),
          ),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: GoogleFonts.amaticSc(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 21,
              )),
              hintStyle: GoogleFonts.amaticSc(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 21))),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.white,
            foregroundColor: appGrey,
            iconSize: 40,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              unselectedItemColor: appGrey,
              selectedItemColor: appPurple),
        ),
        home: const AuthGate(),
      ),
    );
  }
}
