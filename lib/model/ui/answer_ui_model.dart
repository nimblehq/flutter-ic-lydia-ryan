import 'package:lydiaryanfluttersurvey/model/response/answer_response.dart';

class AnswerUiModel {
  final String id;
  final String? text;
  final int score;
  final String? inputMaskPlaceholder;

  AnswerUiModel(
      this.id,
      this.text,
      this.score,
      this.inputMaskPlaceholder,
  );

  factory AnswerUiModel.fromAnswerResponse(AnswerResponse e) {
    return AnswerUiModel(
      e.id,
      e.text,
      e.score,
      e.inputMaskPlaceholder,
    );
  }
}
