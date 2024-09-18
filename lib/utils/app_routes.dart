import 'package:flutter/material.dart';
import 'package:mirror_wall_app/views/screens/home_page/home_page.dart';
import 'package:mirror_wall_app/views/screens/splash_page/splash_page.dart';

class AppRoutes {
  String splashPage = '/';
  String homePage = 'homePage';

  Map<String, WidgetBuilder> allRoutes = {
    '/': (context) => const SplashPage(),
    'homePage': (context) => const HomePage(),
  };
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();
}
