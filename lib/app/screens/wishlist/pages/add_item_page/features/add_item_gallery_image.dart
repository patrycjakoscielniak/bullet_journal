import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/add_item_cubit.dart';

class AddItemWithGalleryImage extends StatelessWidget {
  const AddItemWithGalleryImage({
    super.key,
    required this.itemName,
    required this.itemImage,
    required this.itemURL,
  });

  final String itemName;
  final XFile? itemImage;
  final String itemURL;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: itemName.isEmpty || itemImage == null
          ? null
          : () {
              if (itemImage != null) {
                context
                    .read<AddItemCubit>()
                    .addItemWithGalleryImage(itemImage!, itemName, itemURL);
              }
              Navigator.of(context).pop();
            },
      child: const Text(
        'Add',
      ),
    );
  }
}
