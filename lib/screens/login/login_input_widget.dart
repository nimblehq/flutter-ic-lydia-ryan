import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class LoginInputWidget extends StatelessWidget {
  const LoginInputWidget({
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPasswordType = false,
    super.key,
  });

  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isPasswordType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLoginInput),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.18),
        contentPadding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingVerticalTextField,
          horizontal: Dimensions.paddingHorizontalTextField,
        ),
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      textInputAction: textInputAction,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
