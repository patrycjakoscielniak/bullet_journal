import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ProfileScreen(
        actions: [
          SignedOutAction(
            (context) {
              Navigator.of(context).pop();
            },
          )
        ],
        avatarSize: 48,
      ),
    );
  }
}
