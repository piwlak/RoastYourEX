import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:roastyourex/models/usuarios.dart';

class FaceAuth {
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Usuario> signInWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        print('User login: ${userCredential.user}');
        Usuario user = Usuario.fromFirebaseUser(userCredential.user!);
        return user;
      } else {
        return Usuario(name: null);
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return Usuario(name: null);
    }
  }

  Future<int> signUpWithFacebook() async {
    this.signOut();
    try {
      final LoginResult result = await facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        // Creating a Firebase user with email and password
        final UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: accessToken.userId +
              '@facebook.com', // Using the Facebook user ID as email
          password:
              accessToken.token, // Using the Facebook access token as password
        );
        // Linking the Facebook credential to the Firebase user
        await userCredential.user!.linkWithCredential(credential);
        return 1;
      } else {
        return 3;
      }
    } catch (e) {
      if (e.toString().contains('already')) {
        return 2;
      } else {
        return 3;
      }
    }
  }

  Future<bool> signOut() async {
    try {
      await facebookAuth.logOut();
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
