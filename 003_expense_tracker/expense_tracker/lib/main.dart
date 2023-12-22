import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  var eColorScheme =
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 182, 252, 167));

  var edColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 125, 146, 208));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: edColorScheme,
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: eColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: eColorScheme.onPrimaryContainer,
          foregroundColor: eColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
            color: eColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: eColorScheme.primaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: eColorScheme.onSecondaryContainer,
                fontSize: 20,
              ),
              labelLarge: TextStyle(
                fontWeight: FontWeight.w700,
                color: eColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
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
  @override
  Widget build(BuildContext context) {
    return const Expenses();
  }
}
