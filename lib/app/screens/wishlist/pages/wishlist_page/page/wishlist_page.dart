import 'package:flutter/material.dart';
import 'package:my_bullet_journal/app/core/injection_container.dart';
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/features/edit_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/wishlist_page_cubit.dart';
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
        return getIt<WishlistPageCubit>()..start();
      },
      child: BlocBuilder<WishlistPageCubit, WishlistPageState>(
        builder: (context, state) {
          final itemModels = state.items;
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
}
