import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/pages/auth/authentification_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: CupertinoColors.systemYellow,
      title: Text("Création de compte"),
    ),
    body: Form(
      key: _key,
      child: Column(
        children: [
          const SizedBox(height: 15),

      Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: TextFormField(
            controller: _emailController,
            autofocus: false,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                    left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                )),
            validator: (value) {
              if(value != null && value.isEmpty) {
                return "ERREUR";
              }
              return null;
            },
          )),
          const SizedBox(height: 15),
      Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: TextFormField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Mot de passe',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(
                    left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                )),
          )),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () async {
            var test = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text
            );
            setState(() {
              print(test.user?.email);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthentificationScreen()));
            });
          }, child: Text('Créer le compte')),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () async {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthentificationScreen()));
            });
          }, child: Text("J'ai déja un compte"))
        ],
      ),
    ),
  );
}
