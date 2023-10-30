import 'package:advanced_basics/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      home: Scaffold(
          body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: const StartScreen())),
    );
  }
}
