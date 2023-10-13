import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('buyers');

  FirebaseAuthService(this._firebaseAuth);

  Future<dynamic> logIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        return 'Wrong email or password.';
      }
      return e.message;
    }
  }

  Future<dynamic> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
