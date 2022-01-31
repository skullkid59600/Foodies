import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/providers/remote/all_meals_reponse.dart';
import 'package:http/http.dart' as http;
import 'package:foodies/data/models/food_byname.dart';

import 'area_screen.dart';
import 'categories_screen.dart';
import '../index/index.dart';
import 'meal_by_name.dart';

class RandomMealScreen extends StatefulWidget {
  const RandomMealScreen({Key? key}) : super(key: key);

  @override
  _RandomMealScreenState createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  List<Meals> listFood = [];
  String _response = 'test';

  Future<void> getRandomRecipe() async {
    var uri = Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_meals_response allMeals = All_meals_response.fromJson(jsonDecode(responseFromApi.body));
      listFood = allMeals.meals ?? [];
    }
    setState(() {
      _response = responseFromApi.body;
    });
  }

  void initState() {
    super.initState();
    getRandomRecipe();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
      ]),
      body: Column(children: [
        const SizedBox(height: 15),
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.grey),
            onPressed: () async {
              setState(() {
                getRandomRecipe();
              });
            },
            child: const Text('Trouver une recette')),
        const SizedBox(height: 15),
        Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: listFood.length,
              itemBuilder: (context, index) {
                final item = listFood[index];
                return MeatItem(item, context);
              },
            ))
      ]));

  Widget MeatItem(Meals meals, BuildContext context) {
    return GestureDetector(
        onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      MealByName(strMeal: meals.strMeal)))
            },
        child: Card(
            child: Row(
          children: [
            Image.network(
              meals.strMealThumb ?? "",
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(meals.strMeal ?? "",
                      textAlign: TextAlign.start,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 20)),
                ),
                const SizedBox(height: 15),
                Text(meals.strCategory ?? "",
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.green, fontSize: 15))
              ],
            )
          ],
        )));
  }
}
