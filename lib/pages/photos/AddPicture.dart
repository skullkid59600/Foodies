import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/models/mesrecettes/article.dart';
import 'package:foodies/data/models/mesrecettes/databaseClient.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPicture extends StatefulWidget {
  @override
  _AddPictureState createState() => new _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
   String? image;
   String? nom;
   String? ingredients;
   String? desc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemYellow,
        centerTitle: true,
        title: Text('Ajouter une recette'),
        actions: <Widget>[
          FlatButton(
              onPressed: ajouter,
              child: new Text(
                'Valider',
                style: new TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Text(
            'Yummm ! j\'ai une nouvelle recette',
            textScaleFactor: 1.4,
            style:
                new TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
          ),
          Card(
            elevation: 10.0,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                (image == null)
                    ? Image(image: AssetImage("assets/images/no_image.jpg"))
                    : new Image.file(new File(image!)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.camera_enhance),
                        onPressed: (() => getImage(ImageSource.camera))),
                    new IconButton(
                        icon: new Icon(Icons.photo_library),
                        onPressed: (() => getImage(ImageSource.gallery)))
                  ],
                ),
                textField(TypeTextField.nom, 'Nom de plat'),
                textField(TypeTextField.ingredients, 'Ingredients'),
                textField(TypeTextField.desc, 'Description'),
              ],
            ),
          )
        ]),
      ),
    );
  }

  TextField textField(TypeTextField type, String label) {
    return new TextField(
      decoration: new InputDecoration(labelText: label),
      onChanged: (String string) {
        switch (type) {
          case TypeTextField.nom:
            nom = string;
            break;
          case TypeTextField.desc:
            desc = string;
            break;
          case TypeTextField.ingredients:
            ingredients = string;
            break;
        }
      },
    );
  }

  void ajouter() {
    print('Ajouter');
    if (nom != null) {
      Map<String, dynamic> map = {'nom': nom,'ingredients': ingredients,'desc': desc};
      if (image != null) {
        map['image'] = image;
      }
      Article article = new Article();
      article.fromMap(map);
      DatabaseClient().upsertArticle(article).then((value) {
        image = null;
        nom = null;
        ingredients = null;
        desc = null;
        Navigator.pop(context);
      });
    }
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    setState(() {
      image = pickedFile!.path;
    });
  }
}

enum TypeTextField { nom, ingredients, desc }
