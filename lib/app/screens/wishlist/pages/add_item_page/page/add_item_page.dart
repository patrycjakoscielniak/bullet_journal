import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/enums.dart';
import '../../../../../core/global_variables.dart';
import '../cubit/add_item_page_cubit.dart';
import '../features/add_item.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({
    super.key,
  });

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  var itemName = '';
  var imageURL = '';
  var itemURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddItemPageCubit, AddItemPageState>(
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
                addItemName(),
                space,
                addImageUrlAddress(),
                space,
                addItemURLAddress(),
              ],
            ),
          );
        },
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
            AddItem(itemName: itemName, imageURL: imageURL, itemURL: itemURL)
          ],
        ),
      ),
    );
  }

  TextField addItemName() {
    return TextField(
      onChanged: (newValue) {
        setState(() {
          itemName = newValue;
        });
      },
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: 'New Item'),
    );
  }

  TextField addImageUrlAddress() {
    return TextField(
      onChanged: (newValue) {
        setState(() {
          imageURL = newValue;
        });
      },
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: 'Image URL Adress'),
    );
  }

  TextField addItemURLAddress() {
    return TextField(
      onChanged: (newValue) {
        setState(() {
          itemURL = newValue;
        });
      },
      textAlign: TextAlign.center,
      decoration: const InputDecoration(hintText: 'Item URL Adress'),
    );
  }
}
