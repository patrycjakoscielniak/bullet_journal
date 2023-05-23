import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/wishlist_item_model.dart';

class WishlistRepository {
  final firebaseRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('wishlist');

  Stream<List<WishlistItemModel>> getWishlistItemStream() {
    return firebaseRef.snapshots().map((querySnapshot) {
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
    final doc = await firebaseRef.doc(id).get();
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
    await firebaseRef.add(
      {
        'name': name,
        'image_URL': imageURL,
        'item_URL': itemURL,
      },
    );
  }

  Future<void> update({required String id, required String itemURL}) async {
    return firebaseRef.doc(id).update({'item_URL': itemURL});
  }

  Future<void> delete({required String id}) async {
    return firebaseRef.doc(id).delete();
  }
}
