import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bullet_journal/auth/user_profile.dart';

import '../habit_tracker/habit_tracker_page.dart';
import '../planner/planner_page.dart';
import '../vision_board/vision_board_page.dart';
import '../wishlist/pages/wishlist_page/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final User currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    //debugPrint(AppLocalizations.of(context)!.helloWorld):
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (currentIndex == 0) {
            return const Text('Log');
          }
          if (currentIndex == 1) {
            return const Text('Wishlist');
          }
          if (currentIndex == 2) {
            return const Text('Planner');
          }
          if (currentIndex == 3) {
            return const Text('Habit Tracker');
          }
          return const Text('Vision Board');
        }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const UserProfileScreen())));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const Text('Log');
        }
        if (currentIndex == 1) {
          return const Wishlist();
        }
        if (currentIndex == 2) {
          return const Planner();
        }
        if (currentIndex == 3) {
          return const HabitTracker();
        }
        return const VisionBoard();
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_alt),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: '',
          ),
        ],
      ),
    );
  }
}
