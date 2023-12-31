import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widget/mian_drawer.dart';
import 'package:meals_app/data/dummy_data.dart';

const kinitalFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Meal> _favouriteMeal = [];
  Map<Filter, bool> _selectedFilters = kinitalFilters;
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

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filter") {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kinitalFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avaiableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeWidget = CategoriesScreen(
      onToggleMealFavourite: _toggleMealFavourite,
      avaialableMeals: avaiableMeals,
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
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
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
