import 'package:flutter/material.dart';
import 'package:valburytestapp/constants.dart';
import 'package:valburytestapp/router.dart' as router;

import 'View/undefined_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => UndefinedView(
            name: settings.name,
          )),
      initialRoute: SplashViewRouter,
    );
  }
}
