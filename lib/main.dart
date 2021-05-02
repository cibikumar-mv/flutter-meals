import 'package:flutter/material.dart';
import 'package:meals/Screens/tabs_screen.dart';
import 'Screens/meal_detail_screen.dart';
import 'Screens/category_meals_screen.dart';
import 'Screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        '/' : (ctx) => TabsScreen(),
        CategoryMealsScreen.routeName : (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName : (ctx) =>  MealDetailScreen(),
      },
      //Ongenerate works when a page is not mentioned in routes.
      onGenerateRoute: (settings){
        // if(settings.name == '/meal-detail')
        // Name of the route can be accessed like this.
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      //It works when a page can't be loaded and loads in the mentioned page.
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => MealDetailScreen());
      },
    );
  }
}
