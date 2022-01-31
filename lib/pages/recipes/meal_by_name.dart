import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:foodies/data/providers/remote/all_meals_reponse.dart';
import 'package:foodies/pages/index/index.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';
import 'package:http/http.dart' as http;

import 'area_screen.dart';
import 'categories_screen.dart';

class MealByName extends StatefulWidget {
  const MealByName({Key? key,  this.strMeal}) : super(key: key);
  final  strMeal;


  @override
  _MealByNameState createState() => _MealByNameState();
}


class _MealByNameState extends State<MealByName> {

  List<Meals> selectedMeal = [];
  @override
  void initState () {
    super.initState();
    getRecipeByName();
  }

  String _response = 'test';


  Future<void> getRecipeByName() async {
    var uri = Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=${widget.strMeal}");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_meals_response allMeals = All_meals_response.fromJson(jsonDecode(responseFromApi.body));
      selectedMeal = allMeals.meals ?? [];
    }
    setState(() {
      _response = responseFromApi.body;
    });
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
        Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: selectedMeal.length,
              itemBuilder: (context, index) {
                final item = selectedMeal[index];
                return MeatItem(item, context);
              },
            ))
      ]));

  Widget MeatItem(Meals meals, BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Stack(
          children: [
          Align(
          alignment: Alignment.topCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  meals.strMealThumb ?? "",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  //image: AssetImage(widget.recipeModel.imgPath),
                ),
              ),
            ),
          ]
          ),
                const SizedBox(width: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column( children: [
                        Text(meals.strMeal ?? "",
                          textAlign: TextAlign.center,
                          style:
                          const TextStyle(color: Colors.brown, fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        const Text("Catégorie : ",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        Text(meals.strCategory?? "",
                            textAlign: TextAlign.center,
                            style:
                            const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        const Text("Région : ",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        Text(meals.strArea?? "",
                            textAlign: TextAlign.center,
                            style:
                            const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        const Text("Instructions : ",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 8,),
                        Text(meals.strInstructions?? "",
                            textAlign: TextAlign.center,
                            style:
                            const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                  ]
                ),
              ),
                  ],
                )
                )
              ],
            );
  }
}
