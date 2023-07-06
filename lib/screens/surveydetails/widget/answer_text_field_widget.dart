import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/app_input_widget.dart';

class AnswerTextFieldWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(List<String>) onAnswered;

  const AnswerTextFieldWidget({
    Key? key,
    required this.question,
    required this.onAnswered,
  }) : super(key: key);

  @override
  State<AnswerTextFieldWidget> createState() => _AnswerTextFieldWidgetState();
}

class _AnswerTextFieldWidgetState extends State<AnswerTextFieldWidget> {
  final List<String> _answers = [];
  final List<TextEditingController> _controllers = [];

  void _onTextChanged(
    int index,
    String text,
  ) {
    _answers[index] = text;
    widget.onAnswered(_answers);
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
    TextField(
      onChanged: (text) => _onTextChanged(-1, text),
      controller: TextEditingController(),
    );

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
