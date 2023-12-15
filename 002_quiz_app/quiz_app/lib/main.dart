import 'package:flutter/material.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget? activeScreen;

  List<String> chosenAnswersList = [];

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen);
    super.initState();
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionsScreen(onChosenAnswer: chooseAnswer);
    });
  }

  void onRestart() {
    setState(() {
      chosenAnswersList = [];
      activeScreen = StartScreen(switchScreen);
    });
  }

  void chooseAnswer(String chosenAnswerListItem) {
    chosenAnswersList.add(chosenAnswerListItem);
    setState(() {
      activeScreen = chosenAnswersList.length != 6
          ? QuestionsScreen(onChosenAnswer: chooseAnswer)
          : ResultScreen(
              chosenAnswers: chosenAnswersList,
              onRestart: onRestart,
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(6, 20, 11, 119),
              Color.fromARGB(255, 0, 19, 61),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: activeScreen),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
