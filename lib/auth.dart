import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String _email, String _password);
  Future<String> createUserWithEmailAndPassword(
      String _email, String _password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> signInWithEmailAndPassword(
      String _email, String _password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email, password: _password);
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String _email, String _password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
