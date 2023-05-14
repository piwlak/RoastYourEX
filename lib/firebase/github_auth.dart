import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';

class GitAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GitHubSignIn _githubSignIn = GitHubSignIn(
    clientId: '1469929fa026667154ad',
    clientSecret: '7ec87145c91c2b36963013bac36dabb0ae384bdd',
    redirectUrl: 'https://roast-your-ex.firebaseapp.com/__/auth/handler',
    title: 'GitHub Connection',
    centerTitle: false,
  );

  Future<bool> signInWithGitHub(BuildContext context) async {
    try {
      final result = await _githubSignIn.signIn(context);

      final githubAuthCredential = GithubAuthProvider.credential(result.token!);
      final authResult =
          await _firebaseAuth.signInWithCredential(githubAuthCredential);
      if (authResult.user != null) {
        return true;
      }
      return false;
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing in with GitHub: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing in with GitHub: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    }
  }

  Future<bool> signUpWithGitHub(BuildContext context) async {
    try {
      final result = await _githubSignIn.signIn(context);
      final githubAuthCredential = GithubAuthProvider.credential(result.token!);
      final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: '${result.token}@github.com',
        password: '${result.token}',
      );
      if (authResult.user != null) {
        await authResult.user!.updateDisplayName(result.token);
        await authResult.user!.sendEmailVerification();
        await authResult.user!.linkWithCredential(githubAuthCredential);
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing up with GitHub: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing up with GitHub: ${e.message}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error signing in with GitHub: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return false;
    }
  }
}
