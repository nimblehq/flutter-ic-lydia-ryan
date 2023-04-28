import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class AnswerEmojiKey {
  AnswerEmojiKey._();

  static Key answerKey(int index) => Key('$index');
}

class AnswerEmojiRatingWidget extends StatefulWidget {
  final String emoji;
  final int count;
  final Function(int) onRated;

  const AnswerEmojiRatingWidget({
    Key? key,
    required this.emoji,
    required this.count,
    required this.onRated,
  }) : super(key: key);

  @override
  State<AnswerEmojiRatingWidget> createState() =>
      _AnswerEmojiRatingWidgetState();
}

class _AnswerEmojiRatingWidgetState extends State<AnswerEmojiRatingWidget> {
  bool isPressed = false;

  List<Widget> get _emojiRatingWidgets {
    List<Widget> widgets = [];
    for (int index = 0; index < widget.count; index++) {
      widgets.add(
        Container(
          margin: const EdgeInsets.all(Dimensions.paddingSmallPlus),
          child: ElevatedButton(
            key: AnswerEmojiKey.answerKey(index),
            onPressed: () => _highlightEmoji(index),
            child: Text(
              key: AnswerEmojiKey.answerKey(index),
              widget.emoji,
              style: !isPressed
                  ? const TextStyle(
                      color: Colors.black45,
                    )
                  : null,
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _emojiRatingWidgets,
    );
  }

  void _highlightEmoji(int index) {
    setState(() {
      isPressed = !isPressed;
      widget.onRated(index);
    });
  }
}
