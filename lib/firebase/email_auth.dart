import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      SnackBar(
        content: Text('User registered: ${userCredential.user}'),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        const SnackBar(
          content: Text('The password provided is too weak.'),
        );
      } else if (e.code == 'email-already-in-use') {
        const SnackBar(
          content: Text('The account already exists for that email.'),
        );
      }
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      SnackBar(
        content: Text('User logged in: ${userCredential.user}'),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const SnackBar(
          content: Text('No user found for that email.'),
        );
      } else if (e.code == 'wrong-password') {
        const SnackBar(
          content: Text('Wrong password provided for that user.'),
        );
      }
      return false;
    }
  }
}
