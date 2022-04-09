import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonneesVides extends StatefulWidget {
  @override
  _DonneesVidesState createState() => new _DonneesVidesState();
}

class _DonneesVidesState extends State<DonneesVides> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body : Column(
           children: <Widget>[
              Lottie.network(
            'https://assets7.lottiefiles.com/packages/lf20_rkgoywwu/`lottie_cancel/data.json'),
              Text("Aucune recette enregistrée",
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: CupertinoColors.systemYellow,
                fontStyle: FontStyle.italic)),
      ],
    ));
  }
}
