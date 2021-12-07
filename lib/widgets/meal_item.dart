import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/meal.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem(
      {@required this.title,
      @required this.imageUrl,
      @required this.affordability,
      @required this.complexity,
      @required this.duration});

  void selectMeal() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectMeal,

      //when you want a card to have a different shape you can do that, RoundedRectangleBorder is common.
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            //Stack allows you to literally stack widgets that overlap each other so it looks more 3d in its layout. commonly used for adding text to an image.
            Stack(
              children: [
                //this widget is used, to use other widget as a child and force it into a certain form, like having top corners be rounded. not used very often.
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  //network means we get the image from the web, width double.infintiy means to takes up all the space but adding fit BoxFit.cover means it will be cropped to fit nicely
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
