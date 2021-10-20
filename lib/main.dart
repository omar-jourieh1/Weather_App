import 'package:asps_ninety_project/view/WeatherScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: weatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
