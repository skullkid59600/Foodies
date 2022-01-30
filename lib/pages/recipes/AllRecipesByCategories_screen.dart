// fichier comprenant les recettes d'une catégorie de bouffe

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AllRecipesByCategories extends StatelessWidget {
  const AllRecipesByCategories({Key? key, this.categories,this.mealId}) : super(key: key);
  final  categories;
  final  mealId;

  @override
  Widget build(BuildContext context) {
    ListView(children: <Widget>[
      Container(
        height: 50,
        color: Colors.amber[600],
        child: const Center(child: Text('Entry A')),
      ),
      Container(
        height: 50,
        color: Colors.amber[500],
        child: const Center(child: Text('Entry B')),
      ),
    ]);
    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(""),
      ),
      body: Container(
        decoration: BoxDecoration(
        ),
      ),
    );
  }
}
