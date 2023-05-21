import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData{
  void saveUserData(User user) {
  String userId = user.uid; // ID único del usuario

  String? name = user.displayName;
  String? photoUrl = user.photoURL;
  String? email = user.email;

  Map<String, dynamic> userData = {
    'name': name,
    'photoUrl': photoUrl,
    'email': email,
  };

  FirebaseFirestore.instance
      .collection('users') // Nombre de la colección donde se almacenarán los datos de usuario
      .doc(userId) // ID del documento será el mismo que el ID del usuario
      .set(userData)
      .then((_) {
        print('Datos de usuario guardados en Firestore');
      })
      .catchError((error) {
        print('Error al guardar los datos de usuario: $error');
      });
}
}