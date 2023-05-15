import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:roastyourex/routes.dart';
import 'package:roastyourex/screens/splash_screen.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:get/get.dart';

Future<void> firebaseMsgSegundoPlanoHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('BK MESSAGE WITH ID:  ${message.messageId}');
}

void _firebaseMsgPrimerPlanoHandler(RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMsgSegundoPlanoHandler);
  FirebaseMessaging.onMessage.listen(_firebaseMsgPrimerPlanoHandler);

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.onTokenRefresh
      .listen((fcmToken) {})
      .onError((err) {});
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handlerMsgOpened(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handlerMsgOpenBackground);
  }

  void _handlerMsgOpened(RemoteMessage message) {
    print('EL MENSAJE HA SIDO ABIERTO');
    _handleMsgOpen(message);
  }

  void _handlerMsgOpenBackground(RemoteMessage message) {
    print('EL MENSAJE HA SIDO EN SEGUNDO PLANO');
    _handleMsgOpen(message);
  }

  void _handleMsgOpen(RemoteMessage message) {}

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      defaultThemeId: "custom_theme",
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme.light(),
        AppTheme(
            id: "dark_theme", // Id(or name) of the theme(Has to be unique)
            description: "My Custom Theme", // Description of theme
            data: ThemeData.from(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: const Color.fromARGB(255, 69, 4, 122),
                    onPrimary: const Color.fromARGB(255, 255, 255, 255),
                    background: const Color.fromARGB(255, 0, 0, 0),
                    onBackground: const Color.fromARGB(255, 255, 255, 255),
                    onSecondary: Color.fromARGB(255, 0, 13, 78),
                    shadow: const Color.fromARGB(255, 255, 255, 255),
                    onPrimaryContainer:
                        const Color.fromARGB(255, 7, 255, 234)))),
        AppTheme(
            id: "custom_theme", // Id(or name) of the theme(Has to be unique)
            description: "My Custom Theme", // Description of theme
            data: ThemeData.from(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Color.fromARGB(255, 255, 130, 57),
                    onPrimary: const Color.fromARGB(255, 255, 255, 255),
                    background: const Color.fromARGB(255, 255, 255, 255),
                    onBackground: const Color.fromARGB(255, 0, 0, 0),
                    secondary: Color.fromARGB(255, 231, 16, 16),
                    onSecondary: Color.fromARGB(255, 187, 38, 38),
                    onPrimaryContainer: Color.fromARGB(255, 231, 36, 36)))),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => GetMaterialApp(
            theme: ThemeProvider.themeOf(themeContext).data,
            title: 'Roast Your EX',
            debugShowCheckedModeBanner: false,
            routes: getApplicationRoutes(),
            initialRoute: Route_login,
            home: SplashScreen(),
          ),
        ),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
