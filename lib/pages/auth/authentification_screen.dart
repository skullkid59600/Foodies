import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodies/pages/auth/create_account_screen.dart';
import 'package:foodies/pages/recipes/categories_screen.dart';
import 'package:foodies/pages/recipes/index.dart';

class AuthentificationScreen extends StatefulWidget {
  const AuthentificationScreen({Key? key}) : super(key: key);

  @override
  _AuthentificationScreenState createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Connexion"),
    ),
    body: Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if(value != null && value.isEmpty) {
                return "ERREUR";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
          ),
          ElevatedButton(onPressed: () async {
            var test = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text
            );
            setState(() {
              print(test.user?.email);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Index()));
            });
          }, child: Text('Connexion')),
          ElevatedButton(onPressed: () async {
            setState(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountScreen()));
            });
          }, child: Text('Création  de  compte'))
        ],
      ),
    ),
  );
}
