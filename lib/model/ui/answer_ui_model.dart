import 'package:lydiaryanfluttersurvey/model/response/answer_response.dart';

class AnswerUiModel {
  final String id;
  final String? text;
  final int? score;
  final String? inputMaskPlaceholder;

  AnswerUiModel({
    required this.id,
    required this.text,
    this.score,
    this.inputMaskPlaceholder,
  });

  factory AnswerUiModel.fromAnswerResponse(AnswerResponse e) {
    return AnswerUiModel(id: e.id, text: e.text);
  }
}
