import 'package:lydiaryanfluttersurvey/model/response/answer_response.dart';

class AnswerUiModel {
  final String id;
  final String? text;
  final String? inputMaskPlaceholder;

  AnswerUiModel({
    required this.id,
    required this.text,
    this.inputMaskPlaceholder,
  });

  factory AnswerUiModel.fromAnswerResponse(AnswerResponse e) {
    return AnswerUiModel(id: e.id, text: e.text);
  }
}
