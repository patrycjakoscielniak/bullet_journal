import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/models/wishlist_item_model.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/cubit/wishlist_page_cubit.dart';

class EditItem extends StatefulWidget {
  const EditItem({
    super.key,
    required this.itemModel,
  });

  final WishlistItemModel itemModel;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  var itemURL = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                children: [
                  Image.network(widget.itemModel.imageURL),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (newValue) {
                        itemURL = newValue;
                      },
                      decoration: InputDecoration(
                        hintText: widget.itemModel.itemURL,
                        label: const Text('Add/Change Item URL Address'),
                      ),
                    ),
                  ),
                  IconButton(
                    key: ValueKey(widget.itemModel.id),
                    onPressed: () {
                      context.read<WishlistPageCubit>().updateItem(
                          documentID: widget.itemModel.id, itemURL: itemURL);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.save),
                  )
                ],
              );
            });
      },
      icon: const Icon(
        Icons.edit_outlined,
      ),
    );
  }
}
