import 'package:flutter/material.dart';
import 'package:foodies/data/models/food_byname.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _Index createState() => _Index();
}

class _Index extends State<Index> {
  List<Meals> listFood = [];
  String _response = 'Bienvenue sur Foodies !';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Form(
      child: Column(
          children: [
            Text(_response),
            Image.network('https://www.themealdb.com/images/meal-icon.png'),
          ]),
    ),
  );
}
