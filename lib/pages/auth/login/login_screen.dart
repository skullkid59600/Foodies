import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/bloc/login_bloc/login_bloc.dart';
import 'package:foodies/data/repository/user_repository.dart';

import 'login_form.dart';
class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),
        backgroundColor: CupertinoColors.systemYellow,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}