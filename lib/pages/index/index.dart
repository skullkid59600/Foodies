import 'package:flutter/material.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:foodies/pages/recipes/categories_screen.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';

import '../recipes/area_screen.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _Index createState() => _Index();
}

class _Index extends State<Index> {
  List<Meals> listFood = [];
  String _response = 'Bienvenue sur Foodies !';


  @override
  Widget build(BuildContext context) => Scaffold(
      body: Form(
        child: Column(children: [
          Text(_response),
          Image.network('https://www.themealdb.com/images/meal-icon.png'),
        ]),
      ),
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'home',
          onPressed: () {
            setState(() {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Index()));
            });
          },
        ),
        TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
            child: const Text('Les catégories'),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ApiFood()));
              });
            }),
        TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
            child: const Text('Régions'),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MealByAreaScreen()));
              });
            }),
        TextButton(
            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
            child: const Text('Plat Aléatoire'),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RandomMealScreen()));
              });
            }),
      ]));
}
