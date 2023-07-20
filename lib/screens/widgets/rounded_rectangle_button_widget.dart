import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class RoundedRectangleButtonWidget extends StatelessWidget {
  const RoundedRectangleButtonWidget({
    required this.onPressed,
    required this.text,
    this.width,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: Dimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.buttonHorizontalPadding),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Dimensions.radiusRoundedRectangleButton),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
      ),
    );
  }
}
