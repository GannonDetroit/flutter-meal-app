import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String id;

  CategoryItem(this.id, this.title, this.color);

  void selectCategory(BuildContext ctx) {
    //Naivgator is a flutter built in class to that helps with navigations between screens.
    //needs to be connected to context
    //decide if you are pushing a new screen onto the stack, poping on off, or some combo.
    //pick Material or Cuperinto PageRoute

    //if doing namedRoutes (you usally will be) do .pushNamed and give the named route
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
        arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    //InkWell is basically a gestureDector that also has a ripple effect on tap.
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(
          15), //same size as the BoxDecoration so the waves of the ripple match their size/shape.
      splashColor: Theme.of(context).colorScheme.primary,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        //instead of color we use decoration for better design and allow us to use a gradient bia the box decoration class
        //there are several types of gradients to pick, we picked linear
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [color.withOpacity(0.7), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
