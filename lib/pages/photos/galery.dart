import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodies/data/models/mesrecettes/article.dart';
import 'package:foodies/data/models/mesrecettes/databaseClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddPicture.dart';
import 'donnees_vides.dart';
import 'dart:io';

class Galery extends StatefulWidget {
  @override
  _GaleryState createState() => new _GaleryState();
}

class _GaleryState extends State<Galery> {
  List<Article>? articles = null;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseClient().allArticles().then((liste) {
      setState(() {
        articles = liste;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: CupertinoColors.systemYellow,
          title: new Text("Mes recettes"),
          actions: <Widget>[
            new FlatButton(onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                return new AddPicture();
              })).then((value) {
                print('On est de retour');
                DatabaseClient().allArticles().then((liste) {
                  setState(() {
                    articles = liste;
                  });
                });
              });
            },
                child: new Text('ajouter', style: new TextStyle(color: Colors.white),))
          ],
        ),
        body: (articles == null || articles!.length == 0)
            ? new DonneesVides()
            : new GridView.builder(
            itemCount: articles!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            itemBuilder: (context, i) {
              Article article = articles ![i];
              return new Card(
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    new Text(article.nom ?? "", textScaleFactor: 1.4,style: TextStyle(color: Colors.black),),
                    SizedBox(height: 10),
                    new Container(
                      height:200 ,
                        child: (article.image == null)
                            ? Image(image: AssetImage("assets/no_image.jpg"))
                            : Image.file(new File(article.image ?? "")),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Text("Les ingredients: ${article.ingredients}", textScaleFactor: 1.4,style: TextStyle(color: Colors.black),),

                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Text("Description: ${article.desc}", textScaleFactor: 1.4,style: TextStyle(color: Colors.black,),textAlign:TextAlign.start,),
                    ),

                  ],
                ),
              );
            })
    );
  }

}