import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class RoundedRectangleButtonWidget extends StatelessWidget {
  const RoundedRectangleButtonWidget({
    required this.onPressed,
    required this.text,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(Dimensions.radiusRoundedRectangleButton),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }
}
