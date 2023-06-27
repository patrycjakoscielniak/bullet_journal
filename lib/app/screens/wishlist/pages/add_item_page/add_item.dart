import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/repositories/wishlist_repository.dart';

import '../../../../core/enums.dart';
import 'cubit/add_page_cubit.dart';

class AddItem extends StatefulWidget {
  const AddItem({
    super.key,
  });

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var itemName = '';
  var imageURL = '';
  var itemURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddItemPageCubit(WishlistRepository()),
        child: BlocConsumer<AddItemPageCubit, AddItemPageState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage!),
                duration: const Duration(seconds: 7),
              ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
              child: ListView(
                children: [
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        itemName = newValue;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'New Item'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        imageURL = newValue;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration:
                        const InputDecoration(hintText: 'Image URL Adress'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (newValue) {
                      setState(() {
                        itemURL = newValue;
                      });
                    },
                    textAlign: TextAlign.center,
                    decoration:
                        const InputDecoration(hintText: 'Item URL Adress'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
        child: Row(
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
            )
          ],
        ),
      ),
    );
  }
}
