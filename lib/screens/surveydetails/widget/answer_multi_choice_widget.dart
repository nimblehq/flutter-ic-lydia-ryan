import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class AnswerMultiChoiceWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(List<String>) onChecked;

  const AnswerMultiChoiceWidget({
    Key? key,
    required this.question,
    required this.onChecked,
  }) : super(key: key);

  @override
  State<AnswerMultiChoiceWidget> createState() =>
      _AnswerMultiChoiceWidgetState();
}

class _AnswerMultiChoiceWidgetState extends State<AnswerMultiChoiceWidget> {
  final List<String> _answers = [];
  final List<int> _checkedIndex = [];

  void _onCheckboxChecked(
    bool? isChecked,
    int index,
    String text,
  ) {
    setState(() {
      if (isChecked == true) {
        _answers.add(widget.question.answers[index].text ?? "");
        _checkedIndex.add(index);
      } else {
        _answers.remove(widget.question.answers[index].text ?? "");
        _checkedIndex.remove(index);
      }
    });
    widget.onChecked(_answers);
  }

  Color? _getAnswerColor(int index) {
    if (_checkedIndex.contains(index)) {
      return Colors.white;
    } else {
      return Colors.white54;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
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
                  child: Expanded(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.question.answers[index].text ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: _getAnswerColor(index),
                                    )),
                            Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                value: _answers.contains(
                                    widget.question.answers[index].text ?? ""),
                                onChanged: (bool? isChecked) =>
                                    _onCheckboxChecked(
                                  isChecked,
                                  index,
                                  widget.question.answers[index].text ?? "",
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
                                thickness: 0.5,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
