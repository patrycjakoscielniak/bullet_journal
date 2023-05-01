import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bullet_journal/auth/user_profile.dart';

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
  var currentIndex = 4;
  @override
  Widget build(BuildContext context) {
    //debugPrint(AppLocalizations.of(context)!.helloWorld):
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Name'),
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
          return const Text('Wishlist');
        }
        if (currentIndex == 2) {
          return const Text('Calendar');
        }
        if (currentIndex == 3) {
          return const Text('HabitTracker');
        }
        return const Text('VisionBoard');
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
