import 'package:flutter/material.dart';

class CircleLoadingIndicator extends StatefulWidget {
  const CircleLoadingIndicator({super.key});

  @override
  State<CircleLoadingIndicator> createState() => _CircleLoadingIndicatorState();
}

class _CircleLoadingIndicatorState extends State<CircleLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
