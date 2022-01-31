import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:foodies/data/models/food_byname.dart';
import 'AllRecipesByCategories_screen.dart';
import 'area_screen.dart';
import 'categories_screen.dart';
import '../index/index.dart';

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
      Food foodByName = Food.fromJson(jsonDecode(responseFromApi.body));
      listFood = foodByName.meals ?? [];
    }
    setState(() {
      _response = responseFromApi.body;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
            child: const Text('Areas'),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MealByAreaScreen()));
              });
            }),
        TextButton(
            style: TextButton.styleFrom(
                primary: Theme.of(context).colorScheme.onPrimary),
            child: const Text('Random meal'),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RandomMealScreen()));
              });
            }),
      ]),
      body: Column(children: [
        ElevatedButton(
            onPressed: () async {
              setState(() {
                getRandomRecipe();
              });
            },
            child: const Text('Trouver une recette')),
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
        //TODO METTRE LE BON ROUTE ET PASSER L'ID
        onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AllRecipesByCategories(mealId: meals.idMeal)))
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
