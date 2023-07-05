import 'package:lydiaryanfluttersurvey/model/response/answer_response.dart';

class AnswerUiModel {
  final String id;
  final String? text;

  AnswerUiModel({
    required this.id,
    required this.text,
  });

  factory AnswerUiModel.fromAnswerResponse(AnswerResponse e) {
    return AnswerUiModel(id: e.id, text: e.text);
  }
}
