import 'package:flutter/material.dart';
import 'package:meals/Models/meals.dart';
import 'package:meals/widgets/meals_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  const FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals.isEmpty) {
      return Center(
        child :Text("You have no favourites yet - start adding some!")
      );
    }
    else{
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            imageUrl: favouriteMeals[index].imageUrl,
            title: favouriteMeals[index].title,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
            duration: favouriteMeals[index].duration,
            // removeItem: _removeMeal,
          );
        },
        itemCount: favouriteMeals.length,
      );

    }
  }
}
