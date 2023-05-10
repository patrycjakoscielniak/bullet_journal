import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/wishlist_item_model.dart';

class WishlistRepository {
  Stream<List<WishlistItemModel>> getWishlistItemStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishlist')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map(
        (doc) {
          return WishlistItemModel(
            id: doc.id,
            name: doc.data()['name'],
            imageURL: doc.data()['image_URL'],
            itemURL: doc.data()['item_URL'],
          );
        },
      ).toList();
    });
  }

  Future<void> add(
    String name,
    String imageURL,
    String itemURL,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishlist')
        .add(
      {
        'name': name,
        'image_URL': imageURL,
        'item_URL': itemURL,
      },
    );
  }

  Future<void> delete({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishlist')
        .doc(id)
        .delete();
  }
}
