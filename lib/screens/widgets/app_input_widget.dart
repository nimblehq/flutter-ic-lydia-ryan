import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class AppInputWidget extends StatelessWidget {
  const AppInputWidget({
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPasswordType = false,
    this.maxLines = 1,
    super.key,
  });

  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isPasswordType;
  final int maxLines;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusLoginInput),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.18),
        contentPadding: const EdgeInsets.only(
          top: Dimensions.paddingTopTextField,
          bottom: Dimensions.paddingBottomTextField,
          left: Dimensions.paddingHorizontalTextField,
          right: Dimensions.paddingHorizontalTextField,
        ),
        hintStyle: const TextStyle(
          color: Colors.white30,
        ),
        suffixIcon: isPasswordType
            ? TextButton(
                child: Text(
                  AppLocalizations.of(context)!.forgot_password,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                ),
                onPressed: () {},
              )
            : null,
      ),
      keyboardType: keyboardType,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
