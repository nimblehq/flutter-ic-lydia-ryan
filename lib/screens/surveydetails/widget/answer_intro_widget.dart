import 'package:flutter/material.dart';

class AnswerIntroWidget extends StatefulWidget {
  final String title;
  final String description;

  const AnswerIntroWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<AnswerIntroWidget> createState() => _AnswerIntroWidgetState();
}

class _AnswerIntroWidgetState extends State<AnswerIntroWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            widget.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
