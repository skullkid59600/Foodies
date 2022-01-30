import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:http/http.dart' as http;

class MealByName extends StatefulWidget {
  const MealByName({Key? key,  this.mealName}) : super(key: key);
  final  mealName;


  @override
  _MealByNameState createState() => _MealByNameState();
}

class _MealByNameState extends State<MealByName> {

  Meals selectedMeal = Meals();

  get mealCategory => selectedMeal.strCategory ;
  String _response = 'test';


  void getRecipe() async {
    var uri = Uri.parse("www.themealdb.com/api/json/v1/1/filter.php?c=Seafood");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      selectedMeal = Meals.fromJson(jsonDecode(responseFromApi.body));
    }
    setState(() {
      _response = responseFromApi.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final selectedMeal = Meals.firstWhere((item) => item.id.contains(categoryName));
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Detail"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(selectedMeal.strMealThumb ?? "", width: 100, height: 100,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      selectedMeal.strMeal ?? "",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer),
                        SizedBox(
                          width: 10,
                        ),
                        // Text(selectedMeal.duration.toString() + " minutes"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.monetization_on),
                        SizedBox(
                          width: 10,
                        ),
                        // Text(selectedMeal.affordability.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ingredients",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    /* Wrap(
                      spacing: 10.0,
                      children: <Widget>[
                        ...selectedMeal.ingredients.map((item) => Chip(
                          backgroundColor: Colors.amber,
                          label: Text(item),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Steps",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ...selectedMeal.steps
                        .map(
                          (item) => Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.check),
                            title: Text(item),
                          ),
                          Divider(),
                        ],
                      ),
                    )
                        .toList(),*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}

