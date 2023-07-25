import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/app_input_widget.dart';

class AnswerTextFieldWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(List<AnswerUiModel>) onAnswer;

  const AnswerTextFieldWidget({
    Key? key,
    required this.question,
    required this.onAnswer,
  }) : super(key: key);

  @override
  State<AnswerTextFieldWidget> createState() => _AnswerTextFieldWidgetState();
}

class _AnswerTextFieldWidgetState extends State<AnswerTextFieldWidget> {
  final Map<AnswerUiModel, String> _answers = {};
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (var element in widget.question.answers) {
      _answers[element] = "";
    }
  }

  void _onTextChanged(
    int index,
    String text,
  ) {
    _answers[widget.question.answers[index]] = text;
    final answers = _answers.entries.map((e) => e.key.copyWith(text: e.value));
    widget.onAnswer(answers.toList());
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
                final controller = TextEditingController();
                controller.addListener(() {
                  _onTextChanged(index, controller.text);
                });
                _controllers.add(controller);
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSmallPlus,
                  ),
                  child: AppInputWidget(
                    controller: controller,
                    hintText: widget.question.answers[index].text ?? "",
                    textInputAction:
                        (index == widget.question.answers.length - 1)
                            ? TextInputAction.done
                            : TextInputAction.next,
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
