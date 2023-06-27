import 'package:flutter/material.dart';
import '../../add_item_page/page/add_item_page.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddItemPage(),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
