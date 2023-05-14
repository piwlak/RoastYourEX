import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roastyourex/routes.dart';
import 'package:roastyourex/screens/splash_screen.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
