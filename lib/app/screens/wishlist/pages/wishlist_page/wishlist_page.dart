import 'package:flutter/material.dart';
import 'package:my_bullet_journal/repositories/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../screens/wishlist/features/add_item.dart';
import 'cubit/wishlist_cubit.dart';
import 'features/delete_item.dart';
import '../../model/wishlist_item_model.dart';
import 'features/edit_item.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit(WishlistRepository())..start(),
      child: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          final itemModels = state.items;

          if (state.errorMessage.isNotEmpty) {
            return Center(
              child: Text('Something went wrong: ${state.errorMessage}'),
            );
          }
          return Scaffold(
            body: _WishlistPageBody(itemModels: itemModels),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddItem(),
                  ),
                );
              },
              mini: true,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}

class _WishlistPageBody extends StatelessWidget {
  const _WishlistPageBody({
    required this.itemModels,
  });

  final List<WishlistItemModel> itemModels;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final itemModel in itemModels) ...[
          Padding(
            padding: const EdgeInsets.all(5),
            child: InkWell(
              onTap: () {
                if (itemModel.itemURL.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Center(child: Text('URL Address Not Provided'))));
                } else {
                  launchUrl(Uri.parse(Uri.decodeComponent(itemModel.itemURL)));
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
                          height: MediaQuery.of(context).size.width * (5 / 13),
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(itemModel.name),
                      ),
                    ),
                    EditItem(
                      itemModel: itemModel,
                    ),
                    DeleteItem(itemModel: itemModel),
                  ],
                ),
              ),
            ),
          )
        ],
      ],
    );
  }
}
