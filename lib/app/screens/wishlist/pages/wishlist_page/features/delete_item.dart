import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../models/wishlist_item_model.dart';
import '../../../../../core/global_variables.dart';
import '../cubit/wishlist_page_cubit.dart';

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
            return FractionallySizedBox(
              widthFactor: 0.9,
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: dialogContainerDecoration,
                      child: Column(
                        children: [
                          Text(
                            'Delete this Item?',
                            style: mainTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Close',
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    if (itemModel.itemURL
                                        .contains('firebasestorage')) {
                                      context
                                          .read<WishlistPageCubit>()
                                          .deleteItemFromStorage(
                                              url: itemModel.itemURL);
                                    }
                                    context
                                        .read<WishlistPageCubit>()
                                        .deleteItemFromFirebase(
                                          documentID: itemModel.id,
                                        );
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 60)
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete_outline,
      ),
    );
  }
}
