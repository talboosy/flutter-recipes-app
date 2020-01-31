import 'dart:ffi';

import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite; 
  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      
      width: 360,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(selectedMeal.ingredients[index])),
                      ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                  itemCount: selectedMeal.ingredients.length),
            ),
            Divider(),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${((index + 1).toString())}'),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider()
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggleFavorite(mealId),
      ),
    );
  }
}
