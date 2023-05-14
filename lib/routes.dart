// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:roastyourex/entry_point.dart';
import 'package:roastyourex/screens/login/LoginPageMobile.dart';
import 'package:roastyourex/screens/login/forgot_password_page.dart';
import 'package:roastyourex/screens/login/forgot_password_verification_page.dart';
import 'package:roastyourex/screens/login/registration_page.dart';
import 'package:roastyourex/screens/onboding/onboding_screen.dart';
import 'package:roastyourex/screens/splash_screen.dart';

const String Route_login = '/login';
const String Route_profile = '/profile';
const String Route_registration = '/registration';
const String Route_forgotPass = '/forgotPass';
const String Route_verificationPass = '/verificationPass';
const String Route_SplasScreen = '/SplashScreen';
const String Route_OnBoardScreen = '/onBoard';
const String Home = 'Home';
const String Profile = 'Profile';
const String Search = 'Search';
const String Notifications = 'Notifications';
const String Favorites = 'Favorites';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginPage(),
    'Home': (BuildContext context) => EntryPoint(number: 0),
    'Search': (BuildContext context) => EntryPoint(number: 2),
    'Notifications': (BuildContext context) => EntryPoint(number: 3),
    'Profile': (BuildContext context) => EntryPoint(number: 4),
    '/profile': (BuildContext context) => EntryPoint(number: 0),
    '/registration': (BuildContext context) => RegistrationPage(),
    '/forgotPass': (BuildContext context) => ForgotPasswordPage(),
    '/SplashScreen': (BuildContext context) => SplashScreen(),
    '/verificationPass': (BuildContext context) =>
        ForgotPasswordVerificationPage(),
    '/onBorard': (BuildContext context) => OnboardingScreen(),
  };
}
