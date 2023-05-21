import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../models/usuarios.dart';

Future<String?> getToken() async{
  if(Platform.isIOS){
    String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
  }
  String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
}
