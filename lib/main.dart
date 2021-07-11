import 'package:flutter/material.dart';
import 'package:flutter_meal_app/dummy-data.dart';
import 'package:flutter_meal_app/models/meal.dart';
import 'package:flutter_meal_app/screen/categories_screen.dart';
import 'package:flutter_meal_app/screen/category_meals_screen.dart';
import 'package:flutter_meal_app/screen/filters_screen.dart';
import 'package:flutter_meal_app/screen/meal_detail_screen.dart';
import 'package:flutter_meal_app/screen/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vegan'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(() {
      if (existingIndex == -1) {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      } else {
        _favouriteMeals.removeAt(existingIndex);
      }
    });
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(
        favouriteMeals: _favouriteMeals,
      ),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              favouriteToggleHandler: _toggleFavourite,
              isFavourite: _isMealFavourite,
            ),
        FiltersScreen.routeName: (ctx) =>
            FiltersScreen(filters: _filters, saveFilters: _setFilters),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (ctx) => CategoriesScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
