import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final String hintText;

  const LoginForm({
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.18),
        contentPadding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 12,
          right: 12,
        ),
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
      ),
    );
  }
}
