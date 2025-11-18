import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile(
      {required String uid,
      required String name,
      required String email,
      String? image}) async {
    try {
      await _firestore.collection('users').doc(uid).set(
        {
          'uid': uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'image': image ??
              'https://img.freepik.com/free-vector/smiling-redhaired-boy-illustration_1308-176664.jpg'
        },
      );
    } catch (e) {
      throw Exception('Failed to save user profile due to the error: $e');
    }
  }
}
