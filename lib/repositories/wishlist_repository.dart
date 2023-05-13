import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../app/screens/wishlist/model/wishlist_item_model.dart';

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

  Future<WishlistItemModel> get({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishlist')
        .doc(id)
        .get();
    return WishlistItemModel(
      id: doc.id,
      name: doc['name'],
      imageURL: doc['image_URL'],
      itemURL: doc['item_URL'],
    );
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

  Future<void> update({required String id, required String itemURL}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishlist')
        .doc(id)
        .update({'item_URL': itemURL});
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
