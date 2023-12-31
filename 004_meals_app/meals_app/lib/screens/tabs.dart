import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favouriteMeal = [];

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavourite(Meal meal) {
    var isExisiting = _favouriteMeal.contains(meal);
    if (isExisiting) {
      setState(() {
        _favouriteMeal.remove(meal);
      });
      _showSnackBar("Item removed");
    } else {
      setState(() {
        _favouriteMeal.add(meal);
      });
      _showSnackBar("Item added");
    }
  }

  int _selectedTabIndex = 0;
  void _selectedTab(index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeWidget = CategoriesScreen(
      onToggleMealFavourite: _toggleMealFavourite,
    );

    if (_selectedTabIndex == 1) {
      activeWidget = MealsScreen(
        title: "Favourites",
        meals: _favouriteMeal,
        onToggleScreen: _toggleMealFavourite,
      );
    }
    return Scaffold(
      body: activeWidget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTab,
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourites"),
        ],
      ),
    );
  }
}
