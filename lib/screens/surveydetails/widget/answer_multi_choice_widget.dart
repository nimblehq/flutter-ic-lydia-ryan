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
  final List<TextEditingController> _controllers = [];

  List<int> _checkedIndex = [];

  void _onCheckboxChecked(
    int index,
    String text,
  ) {
    setState(() {
      print(text);
      _answers[index] = text;
      print(_answers.toString());
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
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    super.dispose();
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
                        CheckboxListTile(
                          dense: true,
                          checkColor: Colors.white54,
                          activeColor: Colors.white,
                          checkboxShape: const CircleBorder(),
                          value: _answers.contains(
                              widget.question.answers[index].text ?? ""),
                          shape: const CircleBorder(),
                          onChanged: (bool? isChecked) {
                            setState(() {
                              if (isChecked == true) {
                                _answers.add(
                                    widget.question.answers[index].text ?? "");
                                _checkedIndex.add(index);
                              } else {
                                _answers.remove(
                                    widget.question.answers[index].text ?? "");
                                _checkedIndex.remove(index);
                              }
                            });
                          },
                          title: Text(widget.question.answers[index].text ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 20,
                                    color: _getAnswerColor(index),
                                  )),
                        ),
                        index < widget.question.answers.length - 1
                            ? const Divider(
                                color: Colors.white,
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
