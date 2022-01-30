// fichier comprenant les recettes d'une catégorie de bouffe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:foodies/data/providers/remote/all_meals_reponse.dart';
import 'package:http/http.dart' as http;

import 'meal_by_name.dart';

class AllRecipesByCategories extends StatefulWidget {
  const AllRecipesByCategories({Key? key,  this.mealCategory}) : super(key: key);
  final  mealCategory;


  @override
    _AllRecipesByCategoriesState createState() => _AllRecipesByCategoriesState();
  }

class _AllRecipesByCategoriesState extends State<AllRecipesByCategories> {

  List<Meals> listMeals = [];

  String _response = 'test';


  Future<void> getRecipes() async {
    var uri = Uri.parse("www.themealdb.com/api/json/v1/1/filter.php?c=beef");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_meals_response allMeals = All_meals_response.fromJson(jsonDecode(responseFromApi.body));
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
              title: Text(listMeals[index].strCategory ?? "vide"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        MealByName(mealName : listMeals[index].strMeal)));
              },
            );
          },
        ),
        appBar: AppBar(title: Text("Recipes"), actions: <Widget>[
          TextButton(
            style: style,
            onPressed: getRecipes,
            child: const Text('test'),
          ),
        ]));
  }}



