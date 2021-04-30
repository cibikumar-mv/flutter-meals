import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/widgets/meals_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static final route = '/category-meals';

  // final String categoryId;
  // final String categoryTitle;
  //
  // CategoryMealsScreen(
  //     this.categoryId,
  //     this.categoryTitle,
  //     );

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String categoryTitle = routeArgs['title'];
    final String categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS.where(
      (meal) {
        return meal.categories.contains(categoryId);
      },
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            imageUrl: categoryMeals[index].imageUrl,
            title: categoryMeals[index].title,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,
            duration: categoryMeals[index].duration,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
