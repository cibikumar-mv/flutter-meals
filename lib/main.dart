import 'package:flutter/material.dart';
import 'package:meals/Screens/filters_screen.dart';
import 'package:meals/Screens/tabs_screen.dart';
import 'package:meals/dummy_data.dart';
import 'Models/meals.dart';
import 'Screens/meal_detail_screen.dart';
import 'Screens/category_meals_screen.dart';
import 'Screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree ){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree ){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan ){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian ){
          return false;
        }
        return true;

      }).toList();
    });

  }

  void _toggleFavourite(String mealId){
    final existitngIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existitngIndex >= 0){
      setState(() {
        _favouriteMeals.removeAt(existitngIndex);
      });
    }
    else{
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  bool _isMealFavourite(String id){
    return _favouriteMeals.any((meal) => meal.id == id);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.orange,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/' : (ctx) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName : (ctx) =>  MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName : (ctx) => FiltersScreen(_filters, _setFilters),
      },
      //Ongenerate works when a page is not mentioned in routes.
      // onGenerateRoute: (settings){
      //   // if(settings.name == '/meal-detail')
      //   // Name of the route can be accessed like this.
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
      // //It works when a page can't be loaded and loads in the mentioned page.
      // onUnknownRoute: (settings){
      //   return MaterialPageRoute(builder: (ctx) => MealDetailScreen());
      // },
    );
  }
}
