import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary/questions_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});

  final List<String> chosenAnswers;

  final void Function() onRestart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();

    final totalQuestions = chosenAnswers.length;
    final correctlyAnsweredQuestions = summaryData.where((data) {
      return data['correct_answer'] == data['user_answer'];
    }).length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Your answered $correctlyAnsweredQuestions out of $totalQuestions",
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: QuestionsSummary(summary: summaryData),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(onPressed: onRestart, child: Text("Restart quiz")),
      ],
    );
  }
}
