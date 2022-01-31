import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/models/food_byareas.dart';
import 'package:foodies/data/providers/remote/all_areas_meals_response.dart';
import 'package:foodies/pages/index/index.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';
import 'package:http/http.dart' as http;

import 'area_screen.dart';
import 'categories_screen.dart';
import 'meal_by_name.dart';

class AllRecipesByArea extends StatefulWidget {
  const AllRecipesByArea({Key? key, this.areas}) : super(key: key);
  final areas;

  @override
  _AllRecipesByAreaState createState() => _AllRecipesByAreaState();
}

class _AllRecipesByAreaState extends State<AllRecipesByArea> {
  List<Meals> listMeals = [];

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  String _response = 'test';

  Future<void> getRecipes() async {
    var uri = Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?a=${widget.areas}");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      AllAreasMealsResponse allMeals =
      AllAreasMealsResponse.fromJson(jsonDecode(responseFromApi.body));
      listMeals = allMeals.meals ?? [];
    }
    setState(() {
      _response = responseFromApi.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
          const Divider(),
          itemCount: listMeals.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listMeals[index].strMeal ?? "vide"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MealByName(strMeal: listMeals[index].strMeal)));
              },
            );
          },
        ),
        appBar: AppBar(
            backgroundColor: CupertinoColors.systemYellow,
            actions: <Widget>[
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
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary),
              child: const Text('Les catégories'),
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ApiFood()));
                });
              }),
          TextButton(
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary),
              child: const Text('Régions'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MealByAreaScreen()));
                });
              }),
          TextButton(
              style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.onPrimary),
              child: const Text('Plat Aléatoire'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RandomMealScreen()));
                });
              }),
        ]));
  }
}
