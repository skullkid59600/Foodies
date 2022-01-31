import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:foodies/data/providers/remote/all_meals_reponse.dart';
import 'package:http/http.dart' as http;

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
        title: Text("Random meal"),
      ),
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
    return GestureDetector(
        onTap: () => {
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
  }}

