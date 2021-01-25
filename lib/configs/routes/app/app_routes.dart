import 'package:ewally/features/login/screen/login_screen.dart';
import 'package:ewally/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';

abstract class AppRoutes {
  static final splashScreen = '/splash';
  static final home = '/home';
  static final login = '/login';

  static getRoutes() {
    return [
      SailorRoute(
        name: AppRoutes.splashScreen,
        builder: (context, args, params) => Scaffold(body: SplashScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
      SailorRoute(
        name: AppRoutes.login,
        builder: (context, args, params) => Scaffold(body: LoginScreen()),
        defaultTransitions: [
          SailorTransition.slide_from_right,
        ],
      ),
    ];
  }
}
