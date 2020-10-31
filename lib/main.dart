import 'package:flutter/material.dart';
import 'package:flutter_app/screens/HomeScreen.dart';
import 'package:flutter_app/screens/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpashScreen(),
    );
  }
}

