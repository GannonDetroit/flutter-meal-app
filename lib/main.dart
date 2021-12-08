import 'package:flutter/material.dart';
import './dummy_data.dart';
import 'screens/filters_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';
import './screens/tabs_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        //check if gluten free filter is on and if a meal is not glutten free, if so return false so we don't see it.
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    //using indexWhere because it will return the meal index number and if the meal is not there (because its a toggle) the index will be -1 and I can know to add it.
    //doing it this way just helps with the if statement check in the next line.
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

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
      home: TabsScreen(_favoriteMeals),
      routes: {
        //note that '/' is already accounted for, its for the home: CategoriesScreen() route.
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
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
      debugShowCheckedModeBanner: false,
    );
  }
}
