import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onChosenAnswer});

  final void Function(String answer) onChosenAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(answer) {
    setState(() {
      widget.onChosenAnswer(answer);
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Text(
            currentQuestion.text,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        ...currentQuestion.getShuffledAnswer().map((item) {
          return AnswerButton(
              question: item,
              onTap: () {
                answerQuestion(item);
              });
        })
      ],
    );
  }
}
