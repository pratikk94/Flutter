import 'package:flutter/material.dart';

class QuestionsIdentifier extends StatelessWidget {
  const QuestionsIdentifier(
      {super.key, required this.isCorrectAnswer, required this.questionIndex});
  final bool isCorrectAnswer;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;
    return Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isCorrectAnswer
              ? Color.fromARGB(255, 64, 194, 58)
              : Color.fromARGB(255, 159, 45, 45),
          borderRadius: BorderRadius.circular(100),
        ),
        child: (Text(
          questionNumber.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        )));
  }
}
