import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  const RegisterButton({Key? key, required VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
      ),
      onPressed: _onPressed,
      child: const Text('Register',style: TextStyle(color: Colors.white)),
    );
  }
}