import 'package:flutter/cupertino.dart';
import 'package:flutter_meal_app/models/meal.dart';
import 'package:flutter_meal_app/widget/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  const FavouritesScreen({Key key, this.favouriteMeals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favouriteMeals.isEmpty
        ? Center(
            child: Text('You have no favourites yet - Start adding some!'),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return MealItem(
                id: favouriteMeals[index].id,
                title: favouriteMeals[index].title,
                imageUrl: favouriteMeals[index].imageUrl,
                duration: favouriteMeals[index].duration,
                complexity: favouriteMeals[index].complexity,
                affordability: favouriteMeals[index].affordability,
              );
            },
            itemCount: favouriteMeals.length,
          );
  }
}
