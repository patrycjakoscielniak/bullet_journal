import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bullet_journal/auth/user_profile.dart';

import '../planner/pages/planner_page/page/planner_page.dart';
import '../vision_board/page/vision_board_page.dart';
import '../wishlist/pages/wishlist_page/page/wishlist_page.dart';

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
  var currentIndex = 1;
  List<Icon> icons = [
    const Icon(Icons.star_border),
    const Icon(Icons.event),
    const Icon(Icons.grid_view)
  ];
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    db
        .collection('users')
        .doc(widget.currentUser.uid)
        .collection('vision_board');
    //debugPrint(AppLocalizations.of(context)!.helloWorld):
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (currentIndex == 0) {
            return const Text('Wishlist');
          }
          if (currentIndex == 1) {
            return const Text('Planner');
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
          return const WishlistPage();
        }
        if (currentIndex == 1) {
          return const PlannerPage();
        }

        return const VisionBoardPage();
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: [
          for (int i = 0; i < 3; i++)
            BottomNavigationBarItem(
              icon: icons[i],
              label: '',
            ),
        ],
      ),
    );
  }
}
