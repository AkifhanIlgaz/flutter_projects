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
          decoration: const BoxDecoration(color: Colors.purple),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/quiz-logo.png", width: 200),
                const SizedBox(height: 20),
                const Text(
                  "Learn Flutter the fun way!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.purple)),
                  child: const Text("Start Quiz"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
