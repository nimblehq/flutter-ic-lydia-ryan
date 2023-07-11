import 'package:lydiaryanfluttersurvey/model/response/question_response.dart';

import 'answer_ui_model.dart';

class QuestionUiModel {
  final String id;
  final String text;
  final DisplayType displayType;
  final PickType pickType;
  final List<AnswerUiModel> answers;

  QuestionUiModel({
    required this.id,
    required this.text,
    required this.displayType,
    required this.pickType,
    required this.answers,
  });

  factory QuestionUiModel.fromQuestionResponse(QuestionResponse e) {
    return QuestionUiModel(
      id: e.id ?? '',
      text: e.text ?? '',
      displayType: e.displayType ?? DisplayType.unknown,
      pickType: e.pick ?? PickType.unknown,
      answers:
          e.answers?.map((e) => AnswerUiModel.fromAnswerResponse(e)).toList() ??
              [],
    );
  }
}
