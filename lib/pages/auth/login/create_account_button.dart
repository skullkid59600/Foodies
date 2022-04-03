import 'package:flutter/material.dart';
import 'package:foodies/data/repository/user_repository.dart';
import 'package:foodies/pages/auth/register/register_screen.dart';


class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  const CreateAccountButton({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text(
        'Create an Account', style: TextStyle(color: Colors.white)
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterScreen(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}