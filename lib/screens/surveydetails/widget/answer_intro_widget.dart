import 'package:flutter/material.dart';

class AnswerIntroWidget extends StatefulWidget {
  final String description;

  const AnswerIntroWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  State<AnswerIntroWidget> createState() => _AnswerIntroWidgetState();
}

class _AnswerIntroWidgetState extends State<AnswerIntroWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.description,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
