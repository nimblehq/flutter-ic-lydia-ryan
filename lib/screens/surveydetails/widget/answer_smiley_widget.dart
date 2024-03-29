import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class AnswerSmileyKey {
  AnswerSmileyKey._();

  static Key answerKey(int index) => Key('$index');
}

class AnswerSmileyWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(AnswerUiModel) onSelect;

  const AnswerSmileyWidget({
    Key? key,
    required this.question,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<AnswerSmileyWidget> createState() => _AnswerSmileyWidgetState();
}

class _AnswerSmileyWidgetState extends State<AnswerSmileyWidget> {
  int? selectedIndex;
  List<String> smileys = ['😡', '😕', '😐', '🙂', '😄'];

  List<Widget> get _smileyWidgets {
    List<Widget> widgets = [];
    for (int index = 0; index < smileys.length; index++) {
      widgets.add(
        Container(
          height: Dimensions.answerEmojiSize,
          width: Dimensions.answerEmojiSize,
          margin: const EdgeInsets.all(Dimensions.paddingSmall),
          child: GestureDetector(
            onTap: () {
              _highlightEmoji(index);
            },
            child: Text(
              key: AnswerSmileyKey.answerKey(index),
              smileys[index],
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
      children: _smileyWidgets,
    );
  }

  void _highlightEmoji(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onSelect(widget.question.answers[index]);
  }

  Color? _getEmojiColor(int index) {
    if (selectedIndex == null) {
      return Colors.black45;
    }
    if (index == selectedIndex!) {
      return null;
    } else {
      return Colors.black45;
    }
  }
}
