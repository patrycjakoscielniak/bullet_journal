import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/add_item_page/features/add_item_with_image_url.dart';
import '../../../../../core/enums.dart';
import '../../../../../core/global_variables.dart';
import '../cubit/add_item_page_cubit.dart';
import '../features/add_item_gallery_image.dart';

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
  XFile? itemImage;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
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
          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: TabBar(
                padding: EdgeInsets.only(top: 60),
                indicatorColor: appPurple,
                indicatorPadding: EdgeInsets.only(top: 15),
                labelColor: Colors.black,
                tabs: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.photo_outlined),
                  ),
                  Icon(
                    Icons.link,
                    size: 30,
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: TabBarView(children: [
                ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(child: addItemName()),
                        IconButton(
                          onPressed: () async {
                            XFile? file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            setState(() {
                              itemImage = file;
                            });
                          },
                          icon: const Icon(Icons.add_a_photo_outlined),
                        )
                      ],
                    ),
                    space,
                    addItemURLAddress(),
                  ],
                ),
                ListView(
                  children: [
                    addItemName(),
                    space,
                    addImageUrlAddress(),
                    space,
                    addItemURLAddress(),
                  ],
                )
              ]),
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
                  DefaultTabController.of(context).index == 0
                      ? AddItemWithGalleryImage(
                          itemName: itemName,
                          itemImage: itemImage,
                          itemURL: itemURL)
                      : AddItemWithImageURL(
                          itemName: itemName,
                          imageURL: imageURL,
                          itemURL: itemURL)
                ],
              ),
            ),
          );
        },
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
      decoration: const InputDecoration(hintText: 'Item Name'),
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
