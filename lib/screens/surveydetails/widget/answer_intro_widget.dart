import 'package:flutter/material.dart';

class AnswerIntroWidget extends StatelessWidget {
  final String title;
  final String description;

  const AnswerIntroWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
