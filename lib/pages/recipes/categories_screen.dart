import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/models/food_categories.dart';
import 'package:foodies/data/providers/remote/all_categories_response.dart';
import 'package:foodies/pages/index/index.dart';
import 'package:foodies/pages/recipes/all_recipes_by_categories_screen.dart';
import 'package:foodies/pages/recipes/area_screen.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';
import 'package:http/http.dart' as http;

class ApiFood extends StatefulWidget {
  const ApiFood({Key? key}) : super(key: key);

  @override
  _ApiFoodState createState() => _ApiFoodState();
}

class _ApiFoodState extends State<ApiFood> {
  List<Categories> listCategories = [];
  String _response = 'test';
  String _text = 'ceci est un text';

  Future<void> getAllCategories() async {
    var uri =
        Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_categories_reponse allCategories =
          All_categories_reponse.fromJson(jsonDecode(responseFromApi.body));
      listCategories = allCategories.categories ?? [];
    }
    setState(() {
      _response = responseFromApi.body;
    });
  }

  void initState() {
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: listCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listCategories[index].strCategory ?? "test"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllRecipesByCategories(
                        strCategory: listCategories[index].strCategory)));
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
