import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/request/question_request.dart';

part 'submit_survey_request.g.dart';

@JsonSerializable()
class SubmitSurveyRequest {
  final String surveyId;
  final List<QuestionRequest> questions;

  SubmitSurveyRequest({
    required this.surveyId,
    required this.questions,
  });

  factory SubmitSurveyRequest.fromJson(Map<String, dynamic> json) =>
      _$SubmitSurveyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitSurveyRequestToJson(this);
}
