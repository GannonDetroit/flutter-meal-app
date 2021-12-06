import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //use GridView.builder for when its a dynamic number or very long number of grid items
    //sliver in flutter are scrollable areas on screen, GridDelegate handles grid structure/layout, withMaxCrossAxisExtent allows us to set a max width for each grid item
    // and will create as many columns as possible for those grid items to set next to each other.
    //childAspectRatio helps you set height in regard to the width (so if width is set to 200, 3/2 ratio means height will be 300)

    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [],
    );
  }
}
