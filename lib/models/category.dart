import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  //default color to orange if none is provided when a new object is created.
  const Category(
      {@required this.id, @required this.title, this.color = Colors.orange});
}
