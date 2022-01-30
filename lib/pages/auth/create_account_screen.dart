import 'package:firebase_auth/firebase_auth.dart';
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
      title: Text("Création de compte"),
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
            var test = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text
            );
            setState(() {
              print(test.user?.email);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AuthentificationScreen()));
            });
          }, child: Text('Créer le compte')),
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
