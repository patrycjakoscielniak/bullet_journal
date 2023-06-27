import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_page_cubit.dart';

class AddItem extends StatelessWidget {
  const AddItem({
    super.key,
    required this.itemName,
    required this.imageURL,
    required this.itemURL,
  });

  final String itemName;
  final String imageURL;
  final String itemURL;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: itemName.isEmpty || imageURL.isEmpty
          ? null
          : () {
              context.read<AddItemPageCubit>().addItem(
                    itemName,
                    imageURL,
                    itemURL,
                  );
              Navigator.of(context).pop();
            },
      child: const Text(
        'Add',
      ),
    );
  }
}
