import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/models/food_areas.dart';
import 'package:foodies/data/providers/remote/all_areas_response.dart';
import 'package:foodies/pages/recipes/all_recipes_by_area_screen.dart';
import 'package:foodies/pages/recipes/categories_screen.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';
import 'package:http/http.dart' as http;

import '../index/index.dart';

class MealByAreaScreen extends StatefulWidget {
  const MealByAreaScreen({Key? key}) : super(key: key);

  @override
  _MealByAreaScreenState createState() => _MealByAreaScreenState();
}

class _MealByAreaScreenState extends State<MealByAreaScreen> {
  List<FoodAreas> listFoodArea = [];

  @override
  void initState () {
    super.initState();
    getAllAreas();
  }
  String _response = 'test';

  Future<void> getAllAreas() async {
    var uri =
        Uri.parse("https://www.themealdb.com/api/json/v1/1/list.php?a=list");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_areas_response allFoodArea = All_areas_response.fromJson(jsonDecode(responseFromApi.body));
      listFoodArea = allFoodArea.meals ?? [];
    }
    setState(() {
      _response = responseFromApi.body;
      print(listFoodArea);
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
            itemCount: listFoodArea.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(listFoodArea[index].strArea ?? "vide"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AllRecipesByArea(
                            areas: listFoodArea[index].strArea)));
                  });
            }),
        appBar: AppBar(
            backgroundColor: CupertinoColors.systemYellow,
            actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'home',
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Index()));
              });
            },
          ),
          TextButton(
              style: style,
              child: const Text('Les catégories'),
              onPressed: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ApiFood()));
                });
              }),
          TextButton(
              style: style,
              child: const Text('Régions'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MealByAreaScreen()));
                });
              }),
          TextButton(
              style: style,
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
