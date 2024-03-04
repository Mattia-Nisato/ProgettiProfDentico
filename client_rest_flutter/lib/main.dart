import 'package:flutter/material.dart';
import 'first_screen.dart';

void main() {
  runApp(MaterialApp(
    home: FirstScreen(),
    theme: ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 80, 78, 78),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ),
    ),
  ));
}