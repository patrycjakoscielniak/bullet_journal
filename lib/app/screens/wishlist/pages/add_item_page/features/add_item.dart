import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/add_item_page_cubit.dart';

class AddItem extends StatelessWidget {
  const AddItem({
    super.key,
    required this.itemName,
    required this.imageURL,
    required this.itemURL,
    required this.itemImage,
  });

  final String itemName;
  final String imageURL;
  final String itemURL;
  final XFile? itemImage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: itemName.isEmpty || itemImage == null
          ? null
          : () {
              if (itemImage != null) {
                context
                    .read<AddItemPageCubit>()
                    .add(itemImage!, itemName, itemURL);
              }

              // context.read<AddItemPageCubit>().addItem(
              //       itemName,
              //       imageURL,
              //       itemURL,
              //     );
              Navigator.of(context).pop();
            },
      child: const Text(
        'Add',
      ),
    );
  }
}
