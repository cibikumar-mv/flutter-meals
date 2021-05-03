import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/Models/meals.dart';
import 'package:meals/widgets/meals_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availableMeals;
  static final routeName = '/category-meals';

  const CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {

    super.initState();


  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData)
    {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final String categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where(
        (meal) {
          return meal.categories.contains(categoryId);
        },
      ).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            imageUrl: displayedMeals[index].imageUrl,
            title: displayedMeals[index].title,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
