import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  //a common practice for routing is to have a static const to avoid type-o related errors
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    //when using named routes that have args to pass data, use this set up, args are coming from categoryItem widget in this case.
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('The Recipes For This Category'),
      ),
    );
  }
}
