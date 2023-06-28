import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/add/cubit/add_event_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/details/cubit/details_page_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart';
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/add_item_page/cubit/add_page_cubit.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';
import 'package:my_bullet_journal/repositories/wishlist_repository.dart';

import '../auth/auth_gate.dart';
import '../repositories/planner_repository.dart';
import 'core/global_variables.dart';
import 'data/planner_remote_data_source.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider<AddEventCubit>(
            create: (context) => AddEventCubit(PlannerRepository(
                remoteDataSource: HolidaysRemoteDioDataSource()))),
        BlocProvider<VisionBoardCubit>(
            create: (context) => VisionBoardCubit(VisionBoardRepository())),
        BlocProvider<AddItemPageCubit>(
          create: (context) => AddItemPageCubit(WishlistRepository()),
        )
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
