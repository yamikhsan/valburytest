import 'package:flutter/material.dart';
import 'package:valburytestapp/View/authentication_view.dart';
import 'package:valburytestapp/View/navigation_view.dart';
import 'package:valburytestapp/Widget/tabbar.dart';
import 'package:valburytestapp/constants.dart';
import 'package:valburytestapp/Widget/list_item.dart';

import 'View/home_view.dart';
import 'View/splash_view.dart';
import 'View/undefined_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashViewRouter:
      return MaterialPageRoute(builder: (context) => SplashView());
    case NavigationViewRouter:
      return MaterialPageRoute(builder: (context) => NavigationView());
    case AuthViewRouter:
      return MaterialPageRoute(builder: (context) => AuthentationView());
    default:
      return MaterialPageRoute(builder: (context) => UndefinedView(name: settings.name,));
  }
}