import 'dart:async';
import 'dart:js_util';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _mssgStream =
      new StreamController.broadcast();
  static Stream<String> get messageStream => _mssgStream.stream;

  static Future InitApp() async {
    //push-- 2do plano
    //await Firebase.initializeApp();
messaging.requestPermission();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN:   $token');

    //handlers
    FirebaseMessaging.onBackgroundMessage(_notBackGroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);

    //local-- 1er plano
  }







  static Future<void> _notBackGroundHandler(RemoteMessage message) async {
    print('BK MESSAGE WITH ID:  ${message.messageId}');
    _mssgStream.add(message.notification?.title ?? 'no title');
    
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    _mssgStream.add(message.notification?.title ?? 'no title');
    print('ON MESSAGE:  ${message.messageId}');
  }

  static Future<void> _onOpenMessageOpenApp(RemoteMessage message) async {
    _mssgStream.add(message.notification?.title ?? 'no title');
    print('ON OPEN MESSAGE:  ${message.messageId}');
  }

  static closeStreams() {
    _mssgStream.close();
  }
}
