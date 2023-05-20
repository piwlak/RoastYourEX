import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getToken() async{
  if(Platform.isIOS){
    String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
  }
  String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
}
