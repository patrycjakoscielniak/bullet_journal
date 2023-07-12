import 'package:flutter/material.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/core/injection_container.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/features/edit_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../add_item_page/page/add_item_page.dart';
import '../cubit/wishlist_cubit.dart';
import '../features/add_item_button.dart';
import '../features/delete_item.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<WishlistCubit>()..start();
      },
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          final itemModels = state.items;
          if (itemModels.isEmpty) {
            return _initialDisplay(context);
          }
          return Scaffold(
            body: ListView(
              children: [
                for (final itemModel in itemModels) ...[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        if (itemModel.itemURL.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Center(
                                      child:
                                          Text('URL Address Not Provided'))));
                        } else {
                          launchUrl(Uri.parse(
                              Uri.decodeComponent(itemModel.itemURL)));
                        }
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.network(
                                  itemModel.imageURL,
                                  alignment: Alignment.bottomLeft,
                                  height: MediaQuery.of(context).size.width *
                                      (4 / 13),
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                itemModel.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            EditItem(itemModel: itemModel),
                            DeleteItem(itemModel: itemModel),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const AddItemButton(),
          );
        },
      ),
    );
  }

  Scaffold _initialDisplay(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(alignment: Alignment.center, children: [
              const Image(image: AssetImage('assets/images/3.png')),
              Column(
                children: [
                  Text(
                    'Add First Item To Your Wishlist',
                    style: initialdiplaysTextStyle,
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddItemPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: appPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      child: const Icon(Icons.add))
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
