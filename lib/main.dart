import 'package:flutter/material.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              ),
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber)),
      home: TabsScreen(),
      routes: {
        //note that '/' is already accounted for, its for the home: CategoriesScreen() route.
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen()
      },
      //this takes a function that takes some route settings (like args) and then it will return a route with a builder,
      //this is only reached when you are going to named route that is NOT registered in the routes table but uses .pushNamed
      //I don't need it on this app (or many app) but its good to note and shows me how to access the settings of routes.
      //mainly used for things when the app needs to dynamically generate routes that don't exist at runtime. Video 171.
      // onGenerateRoute: (settings){
      //   print(settings.arguments);
      //   if (settings.name == '/meal-detail'){
      //     return ...
      //   } else if (settings.name == '/something-else'){
      //     return ...
      //   }
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },

      //takes an anon function that gets settings about the route it tried to load and which returns a route. this route is reached when fluttter
      //failes to build a screen via all other measures (its a last resort). So the route/widget it would show would typically be a starting page or
      // '404: we couldn't find that page, please go back or try again'
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
