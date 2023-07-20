import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/response/question_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class AnswerMultiChoiceWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(List<AnswerUiModel>) onCheck;

  const AnswerMultiChoiceWidget({
    Key? key,
    required this.question,
    required this.onCheck,
  }) : super(key: key);

  @override
  State<AnswerMultiChoiceWidget> createState() =>
      _AnswerMultiChoiceWidgetState();
}

class _AnswerMultiChoiceWidgetState extends State<AnswerMultiChoiceWidget> {
  final Set<String> _checkedAnswerIds = {};

  void _onCheckboxChecked(
    bool? isChecked,
    String answerId,
  ) {
    setState(() {
      if (isChecked == true) {
        if (widget.question.pickType == PickType.single) {
          _checkedAnswerIds.clear();
        }
        _checkedAnswerIds.add(answerId);
      } else {
        _checkedAnswerIds.remove(answerId);
      }
    });
    final answers = widget.question.answers
        .where((answer) => _checkedAnswerIds.contains(answer.id))
        .toList();
    widget.onCheck(answers);
  }

  bool _isFoundAnswerId(int index) =>
      _checkedAnswerIds.contains(widget.question.answers[index].id);

  Color? _getAnswerColor(int index) {
    if (_isFoundAnswerId(index)) {
      return Colors.white;
    } else {
      return Colors.white54;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.question.pickType == PickType.unknown) {
      return const SizedBox();
    }

    return Center(
      child: ListView(
        shrinkWrap: true,
        children: [
          ...List<Widget>.generate(
            widget.question.answers.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingLarge,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.question.answers[index].text ?? "",
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: _getAnswerColor(index),
                                    )),
                        Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            value: _isFoundAnswerId(index),
                            onChanged: (bool? isChecked) => _onCheckboxChecked(
                              isChecked,
                              widget.question.answers[index].id,
                            ),
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            checkColor: Colors.black,
                            shape: const CircleBorder(),
                            side: const BorderSide(
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    index < widget.question.answers.length - 1
                        ? const Divider(
                            color: Colors.white,
                            thickness: Dimensions.dividerWidth,
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
