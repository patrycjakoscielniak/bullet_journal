import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/wishlist_item_model.dart';
import '../cubit/wishlist_cubit.dart';

class DeleteItem extends StatelessWidget {
  const DeleteItem({
    super.key,
    required this.itemModel,
  });

  final WishlistItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext contex) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'Delete Item',
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    const Text('Are you sure you want to delete item?'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            key: ValueKey(itemModel.id),
                            onPressed: () {
                              context
                                  .read<WishlistCubit>()
                                  .deleteItem(documentID: itemModel.id);
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
    );
  }
}
