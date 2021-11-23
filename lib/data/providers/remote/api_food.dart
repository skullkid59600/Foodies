import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/models/food_categories.dart';
import 'package:foodies/data/providers/remote/all_categories_response.dart';
import 'package:foodies/pages/screen_categories.dart';
import 'package:http/http.dart' as http;

class ApiFood extends StatefulWidget {
  const ApiFood({Key? key}) : super(key: key);

  @override
  _ApiFoodState createState() => _ApiFoodState();
}

class _ApiFoodState extends State<ApiFood> {
  List<Categories> listCategories = [];
  String _response = 'test';

  Future<void> getAllCategories() async {
    var uri = Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php");
    var responseFromApi = await http.get(uri);

    if (responseFromApi.statusCode == 200) {
      All_categories_reponse allCategories =
          All_categories_reponse.fromJson(jsonDecode(responseFromApi.body));
      listCategories = allCategories.categories ?? [];
    }
    debugPrint(responseFromApi.body);
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
          itemCount: listCategories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(listCategories[index].strCategory ?? "vide"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ScreenCategories(categories: listCategories[index])));
              },
            );
          },
        ),
        appBar: AppBar(title: Text("get categories"), actions: <Widget>[
          TextButton(
            style: style,
            onPressed: getAllCategories,
            child: const Text('GETTER'),
          ),
        ]));
  }
}
