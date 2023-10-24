import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

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
      setUpUser();
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<dynamic> setUpUser() async {
    try {
      Map<String, dynamic> data = {};
      await users.doc(FirebaseAuth.instance.currentUser!.uid).set(data);
      _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
