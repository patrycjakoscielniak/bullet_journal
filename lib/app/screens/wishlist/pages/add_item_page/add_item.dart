import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bullet_journal/repositories/wishlist_repository.dart';

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
      appBar: AppBar(
        title: Text(
          'Add Item',
          style: GoogleFonts.tangerine(
              textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 35,
          )),
        ),
      ),
      body: BlocProvider(
        create: (context) => AddItemPageCubit(WishlistRepository()),
        child: BlocListener<AddItemPageCubit, AddItemPageState>(
          listener: (context, state) {
            if (state.saved) {
              Navigator.of(context).pop();
            }
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.errorMessage),
                duration: const Duration(seconds: 7),
              ));
            }
          },
          child: BlocBuilder<AddItemPageCubit, AddItemPageState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    TextField(
                      onChanged: (newValue) {
                        setState(() {
                          itemName = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text('Name'),
                        hintText: 'Trench Coat',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (newValue) {
                        setState(() {
                          imageURL = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text('Image URL Adress'),
                        hintText: 'http:// ... .jpg ',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      onChanged: (newValue) {
                        setState(() {
                          itemURL = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text('Item URL Adress'),
                        hintText: 'http:// ... ',
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: itemName.isEmpty || imageURL.isEmpty
                          ? null
                          : () {
                              context.read<AddItemPageCubit>().addItem(
                                    itemName,
                                    imageURL,
                                    itemURL,
                                  );
                            },
                      child: const Text('Add'),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
