// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_item_cubit.dart';

class AddItemWithImageURL extends StatelessWidget {
  const AddItemWithImageURL({
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
              context.read<AddItemCubit>().addItemwithImageURL(
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
