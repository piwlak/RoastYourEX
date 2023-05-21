import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Suscription {
  final user = FirebaseAuth.instance.currentUser;

  Future<void> getSuscripted(String userName) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    String? userId = await getUserId(userName);
    if (userId != null) {
      await FirebaseMessaging.instance.subscribeToTopic(userId);
      print('El usuario ha sido seguido');
    } else {
      print('El usuario no existe o no se encontró');
      print(userName);

    }
    //await FirebaseMessaging.instance.subscribeToTopic(user!.uid);
  }

  Future<String?> getUserId(String userName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              'users') // Reemplaza con el nombre de tu colección de usuarios
          .where('name', isEqualTo: userName)
          .get();

      if (querySnapshot.size > 0) {
        return querySnapshot.docs.first.id; // Obtén el ID del primer documento
      } else {
        return null; // El usuario no existe o no se encontró
      }
    } catch (e) {
      print('Error al obtener el ID del usuario: $e');
      return null;
    }
  }

  Future<String?> getNameUser()async{

  }
}
