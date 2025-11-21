import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static Future<String?> uploadImageToFirebase(
      {required File imageFile, String folder = '', String imageName = ''}) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images${folder.isEmpty ? '' : '/$folder'}')
          .child(
              '${imageName.isEmpty ? '' : '$imageName - '}${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = await storageRef.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Upload failed: $e');
      return null;
    }
  }
}
