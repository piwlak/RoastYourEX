import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  final String? name;
  final String? photoUrl;
  final String? email;

  Usuario({this.name, this.photoUrl, this.email});

  factory Usuario.fromFirebaseUser(User firebaseUser) {
    String? name = firebaseUser.providerData[0].displayName;
    String? photoUrl = firebaseUser.providerData[0].photoURL;
    String? email = firebaseUser.providerData[0].email;
    Usuario aux = Usuario(name: name, photoUrl: photoUrl, email: email);
    return aux;
  }
}
