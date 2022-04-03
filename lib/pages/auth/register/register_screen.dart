import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/bloc/register_bloc/register_bloc.dart';
import 'package:foodies/data/repository/user_repository.dart';
import 'package:foodies/pages/auth/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen({Key? key, required UserRepository userRepository})
      :_userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register'),
        backgroundColor: CupertinoColors.systemYellow,
      ),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}