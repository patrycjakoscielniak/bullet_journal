import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/details/cubit/details_page_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';

import '../auth/auth_gate.dart';
import '../repositories/planner_repository.dart';
import 'data/planner_remote_data_source.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final appPurple = const Color.fromARGB(255, 160, 117, 217);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlannerCubit>(
            create: (context) => PlannerCubit(PlannerRepository(
                remoteDataSource: HolidaysRemoteDioDataSource()))),
        BlocProvider<EditEventCubit>(
            create: (context) => EditEventCubit(PlannerRepository(
                remoteDataSource: HolidaysRemoteDioDataSource()))),
        BlocProvider<DetailsPageCubit>(
            create: (context) => DetailsPageCubit(PlannerRepository(
                remoteDataSource: HolidaysRemoteDioDataSource()))),
        BlocProvider<VisionBoardCubit>(
            create: (context) => VisionBoardCubit(VisionBoardRepository())),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
