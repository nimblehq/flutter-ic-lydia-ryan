import 'package:json_annotation/json_annotation.dart';

part 'submit_survey_answer_request.g.dart';

@JsonSerializable()
class SubmitSurveyAnswerRequest {
  final String id;
  final String? answer;

  SubmitSurveyAnswerRequest({required this.id, this.answer});

  factory SubmitSurveyAnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyAnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyAnswerRequestToJson(this);
}
