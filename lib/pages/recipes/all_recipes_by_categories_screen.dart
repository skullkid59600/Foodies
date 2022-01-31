// fichier comprenant les recettes d'une catégorie de bouffe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:foodies/data/providers/remote/all_meals_reponse.dart';
import 'package:foodies/pages/index/index.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';
import 'package:http/http.dart' as http;

import 'area_screen.dart';
import 'categories_screen.dart';
import 'meal_by_name.dart';

class AllRecipesByCategories extends StatefulWidget {
  const AllRecipesByCategories({Key? key, this.strCategory}) : super(key: key);
  final strCategory;

  @override
  _AllRecipesByCategoriesState createState() => _AllRecipesByCategoriesState();
}

class _AllRecipesByCategoriesState extends State<AllRecipesByCategories> {
  List<Meals> listMeals = [];

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  String _response = 'test';

  Future<void> getRecipes() async {
    var uri = Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.strCategory}");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_meals_response allMeals =
          All_meals_response.fromJson(jsonDecode(responseFromApi.body));
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
