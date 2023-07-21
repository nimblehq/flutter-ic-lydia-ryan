import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/app_input_widget.dart';

class AnswerTextAreaWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(AnswerUiModel) onAnswer;

  const AnswerTextAreaWidget({
    Key? key,
    required this.question,
    required this.onAnswer,
  }) : super(key: key);

  @override
  State<AnswerTextAreaWidget> createState() => _AnswerTextAreaWidgetState();
}

class _AnswerTextAreaWidgetState extends State<AnswerTextAreaWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => {
          widget.onAnswer(
            widget.question.answers.first.copyWith(
              text: _controller.text,
            ),
          )
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: AppInputWidget(
          controller: _controller,
          hintText: widget.question.answers.first.text ?? "",
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
        ),
      ),
    );
  }
}
