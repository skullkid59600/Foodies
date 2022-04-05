import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:foodies/bloc/authentication_bloc/authentication_event.dart';
import 'package:foodies/data/models/food_byname.dart';
import 'package:foodies/pages/recipes/categories_screen.dart';
import 'package:foodies/pages/recipes/random_meal_screen.dart';

import '../recipes/area_screen.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _Index createState() => _Index();
}

class _Index extends State<Index> {
  List<Meals> listFood = [];
  final String _response = 'Bienvenue sur Foodies';
  final String _textindex = 'Une application pour les gourmands!';

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
          child: Column(children: [
            Text(_response,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text(_textindex,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.brown, fontSize: 16)),
            Image.network(
              'https://www.themealdb.com/images/meal-icon.png',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ]),
        ),
        appBar: AppBar(
            backgroundColor: CupertinoColors.systemYellow,
        ),
        drawer: Drawer(
            child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: [
                  Image.asset('assets/images/foodies.png', width: 70),
                  IconButton(
                    icon: const Icon(Icons.logout,color: Colors.white,),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        LoggedOut(),
                      );
                    },
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color:CupertinoColors.systemYellow,
              ),
            ),
            ListTile(
              title: Text('Les catégories'),
              onTap: () {
                setState(() {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ApiFood()));
                });
              },
            ),
            ListTile(
              title: Text('Régions'),
              onTap: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MealByAreaScreen()));
                });
              },
            ),
            ListTile(
              title: Text('Plat Aléatoire'),
              onTap: () {
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RandomMealScreen()));
                });
              },
            ),
          ],
        )),
      );
}
