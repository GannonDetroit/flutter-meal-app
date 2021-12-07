import 'package:flutter/material.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem(
      {@required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.affordability,
      @required this.complexity,
      @required this.duration});

  //using a getter to dynamically compute a variables value.
  String get complexityText {
    //since i'm returning in each of these cases the break statement is not actually needed. BUT if i was just doing some calculation or something for a case
    //then I WOULD want to break otherwise its going to keep going through options and hit default too.
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Expensive';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(MealDetailScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),

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
                ),
                //softwrap is for if the text in the card is too long it will wrap
                //overflow set to fade so if even wrapping isn't enough, the text will be clipped in the box and fade out (shouldn't happen but this is a safety check)
                //Positioned is a widget you can call ONLY in stacked that allows you to put a child in an absolute coordinate in the parent space. by saying how many pixels away from the bottom, right or whatever you want it to be.
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    //this container to help constrain the width of the text so the softwrap and overflow args actually work.
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            //-------row of info below the image----------
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //-------the dureaction aspect ------
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration min')
                    ],
                  ),
                  //--------the complexity aspect -------
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexityText)
                    ],
                  ),
                  //--------the affordability aspect -------
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityText)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
