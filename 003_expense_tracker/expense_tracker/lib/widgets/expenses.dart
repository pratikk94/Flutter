import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registeredExpenses = [
    Expense(
        title: "Flutter course",
        amount: 499,
        category: Category.work,
        date: DateTime.now()),
    Expense(
        title: "Movie",
        amount: 299,
        category: Category.leisure,
        date: DateTime.now())
  ];

  _showModalSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(addExpense: _addExpense);
        });
  }

  void _addExpense(Expense e) {
    setState(() {
      registeredExpenses.add(e);
    });
  }

  void _removeExpense(Expense e) {
    var index = registeredExpenses.indexOf(e);

    setState(() {
      registeredExpenses.remove(e);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Item deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registeredExpenses.insert(index, e);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text("No expense logged"));

    if (!registeredExpenses.isEmpty) {
      mainContent = ExpensesList(
          expenses: registeredExpenses, removeExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _showModalSheet,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
