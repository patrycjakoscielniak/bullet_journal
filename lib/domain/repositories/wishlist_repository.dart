import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import '../models/wishlist_item_model.dart';

@injectable
class WishlistRepository {
  final storageRef = FirebaseStorage.instance.ref().child('wishlist');
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
            imageURL: doc.data()['image'],
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
    await firebaseRef.add(
      {
        'name': name,
        'image': imageURL,
        'item_URL': itemURL,
      },
    );
  }

  Future<void> addItem(XFile image, String name, String itemURL) async {
    Reference imageToUploadRef = storageRef.child(image.name);
    UploadTask uploadTask = imageToUploadRef.putFile(File(image.path));
    String imageUrl = await (await uploadTask).ref.getDownloadURL();
    final dataToSend = {
      'image': imageUrl,
      'onCreated': DateTime.now(),
      'name': name,
      'item_URL': itemURL,
    };
    firebaseRef.add(dataToSend);
  }

  Future<void> update({required String id, required String itemURL}) async {
    return firebaseRef.doc(id).update({'item_URL': itemURL});
  }

  Future<void> deleteFromFirebase({required String id}) async {
    return firebaseRef.doc(id).delete();
  }

  Future<void> deleteFromStorage({required String url}) async {
    FirebaseStorage.instance.refFromURL(url).delete();
  }
}
