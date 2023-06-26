import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_bullet_journal/models/vision_board_model.dart';

class VisionBoardRepository {
  final storageRef = FirebaseStorage.instance.ref().child('images');
  final firestoreRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('vision_board');

  Stream<List<VisionBoardModel>> getVisionBoardItemStream() {
    return firestoreRef
        .orderBy('onCreated', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return VisionBoardModel(
            image: doc.data()['image'],
            id: doc.id,
            onCreated: doc.data()['onCreated']);
      }).toList();
    });
  }

  Future<void> uploadImage(XFile image) async {
    Reference imageToUploadRef = storageRef.child(image.name);
    UploadTask uploadTask = imageToUploadRef.putFile(File(image.path));
    String imageUrl = await (await uploadTask).ref.getDownloadURL();
    final dataToSend = {
      'image': imageUrl,
      'onCreated': DateTime.now(),
    };
    firestoreRef.add(dataToSend);
  }

  Future<void> deleteImage({required String url, required String id}) async {
    FirebaseStorage.instance.refFromURL(url).delete();
    firestoreRef.doc(id).delete();
  }
}
