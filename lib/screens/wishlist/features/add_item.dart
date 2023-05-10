import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bullet_journal/screens/wishlist/cubit/wishlist_cubit.dart';
import 'package:my_bullet_journal/screens/wishlist/repository/wishlist_repository.dart';

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
        create: (context) => WishlistCubit(WishlistRepository()),
        child: BlocListener<WishlistCubit, WishlistState>(
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
          child: BlocBuilder<WishlistCubit, WishlistState>(
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
                              context.read<WishlistCubit>().addItem(
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
