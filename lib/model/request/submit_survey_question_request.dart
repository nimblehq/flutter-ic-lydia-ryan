import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/request/submit_survey_answer_request.dart';

part 'submit_survey_question_request.g.dart';

@JsonSerializable()
class SubmitSurveyQuestionRequest {
  final String id;
  final List<SubmitSurveyAnswerRequest> answers;

  SubmitSurveyQuestionRequest({
    required this.id,
    required this.answers,
  });

  factory SubmitSurveyQuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyQuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyQuestionRequestToJson(this);
}
