import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //Optionally, update display name:
      userCredential.user?.updateDisplayName(name);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseError(e));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'Email is already in use.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
