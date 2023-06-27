import 'package:flutter/material.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';

import '../../add_item_page/page/add_item_page.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: appPurple,
      foregroundColor: Colors.white,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddItemPage(),
          ),
        );
      },
      mini: true,
      child: const Icon(Icons.add),
    );
  }
}
