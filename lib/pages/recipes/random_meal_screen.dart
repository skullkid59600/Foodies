import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:foodies/data/models/food_byname.dart';

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
      Food foodByName =
      Food.fromJson(jsonDecode(responseFromApi.body));
      listFood = foodByName.meals ?? [];
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
    body: Form(
      child: Column(
        children: [
          Text(_response),
          ElevatedButton(onPressed: () async {
            setState(() {
              getRandomRecipe();
            });
          }, child: Text('Trouver une recette')),
        ]),
    ),
  );
}
