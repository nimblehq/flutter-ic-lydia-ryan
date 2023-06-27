import 'package:lydiaryanfluttersurvey/model/response/answer_response.dart';

class AnswerUiModel {
  final String id;
  final String? text;

  AnswerUiModel(
    this.id,
    this.text,
  );

  factory AnswerUiModel.fromAnswerResponse(AnswerResponse e) {
    return AnswerUiModel(
      e.id,
      e.text,
    );
  }
}
