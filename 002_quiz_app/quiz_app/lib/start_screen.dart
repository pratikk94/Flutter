import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          "assets/quiz-logo.png",
          width: 280,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "Let's test your flutter knowledge",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
          onPressed: () {
            startQuiz();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 20),
              padding: const EdgeInsets.all(20)),
          child: const Text("Start quiz"),
        )
      ],
    );
  }
}
