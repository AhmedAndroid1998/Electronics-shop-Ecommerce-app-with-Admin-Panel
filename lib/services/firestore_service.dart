import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> createUserProfile(
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

  static Future<bool> loginAdmin(
      {required String username, required String password}) async {
    try {
      /*
      The reason for chaining  where() twice below is the following:
        Firestore does not support compound value comparisons inside
        a single where() call. So,  You cannot write:
          .where("username == 'abc' AND password == '123'")
        Firestore requires one condition per field, so your query must be:
       */
      final query = await _firestore
          .collection('admin')
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();
      if (query.docs.isNotEmpty) {
        return true;
      }

      Fluttertoast.showToast(
        msg: 'Incorrect username or password',
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );

      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
      return false;
    }
  }

  static Future<void> addProduct({
    required String category,
    required String productName,
    required String imageUrl,
    String? productDetails,
    required double price,
  }) async {
    try {
      await _firestore.collection(category).add(
        {
          'category': category,
          'name': productName,
          'imageUrl': imageUrl,
          'details': productDetails,
          'price': price,
          'addedOn': FieldValue.serverTimestamp(),
        },
      );
    } catch (e) {
      throw Exception('Failed to save user profile due to the error: $e');
    }
  }
}
