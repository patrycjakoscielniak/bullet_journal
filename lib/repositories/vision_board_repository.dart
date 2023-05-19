import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_bullet_journal/app/screens/vision_board/model/vision_board_model.dart';

class VisionBoardRepository {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  Stream<List<VisionBoardModel>> getVisionBoardItemStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('vision_board')
        .orderBy('onCreated', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return VisionBoardModel(image: doc.data()['image'], id: doc.id);
      }).toList();
    });
  }

  Future<void> uploadImage(XFile image) async {
    Reference rootRef = FirebaseStorage.instance.ref();
    Reference folderRef = rootRef.child('images');
    Reference imageToUploadRef = folderRef.child(image.name);
    UploadTask uploadTask = imageToUploadRef.putFile(File(image.path));
    String imageUrl = await (await uploadTask).ref.getDownloadURL();
    final dataToSend = {
      'image': imageUrl,
      'onCreated': DateTime.now(),
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('vision_board')
        .add(dataToSend);
  }
}
