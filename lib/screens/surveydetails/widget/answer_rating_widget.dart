import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class AnswerEmojiKey {
  AnswerEmojiKey._();

  static Key answerKey(int index) => Key('$index');
}

class AnswerEmojiRatingWidget extends StatefulWidget {
  final String emoji;
  final int count;
  final Function(int) onRatingChange;

  const AnswerEmojiRatingWidget({
    Key? key,
    required this.emoji,
    required this.count,
    required this.onRatingChange,
  }) : super(key: key);

  @override
  State<AnswerEmojiRatingWidget> createState() =>
      _AnswerEmojiRatingWidgetState();
}

class _AnswerEmojiRatingWidgetState extends State<AnswerEmojiRatingWidget> {
  int? selectedIndex;

  List<Widget> get _emojiRatingWidgets {
    List<Widget> widgets = [];
    for (int index = 0; index < widget.count; index++) {
      widgets.add(
        Container(
          height: Dimensions.answerEmojiSize,
          width: Dimensions.answerEmojiSize,
          margin: const EdgeInsets.all(Dimensions.paddingSmall),
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              for (int highlightIndex = 0;
                  highlightIndex <= index;
                  highlightIndex++) {
                _highlightEmoji(highlightIndex);
              }
            },
            child: Text(
              key: AnswerEmojiKey.answerKey(index),
              widget.emoji,
              style: TextStyle(
                color: _getEmojiColor(index),
                fontSize: 28,
              ),
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
      selectedIndex = index;
    });
    widget.onRatingChange(index);
  }

  Color? _getEmojiColor(int index) {
    if (selectedIndex == null) {
      return Colors.black45;
    }
    if (index <= selectedIndex!) {
      return null;
    } else {
      return Colors.black45;
    }
  }
}
