import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/add_item_page_cubit.dart';

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
              context.read<AddItemPageCubit>().addItemwithImageURL(
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
