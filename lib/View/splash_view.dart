import 'dart:async';

import 'package:flutter/material.dart';
import 'package:valburytestapp/constants.dart';

class SplashView extends StatefulWidget {
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), ()=> { Navigator.pushReplacementNamed(context, AuthViewRouter) });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/flutter-logo.jpg', scale: 3,),
              Text('Company Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Text('Slogan', style: TextStyle(fontSize: 18, color: Colors.black38, letterSpacing: 12),),
            ],
          ),
        ),
      ),
    );
  }
}
