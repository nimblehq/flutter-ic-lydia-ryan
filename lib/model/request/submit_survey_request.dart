import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/request/answer_request.dart';
import 'package:lydiaryanfluttersurvey/model/request/question_request.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';

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

  factory SubmitSurveyRequest.fromValues({
    required String surveyId,
    required Map<String, List<AnswerUiModel>> questionAnswerMap,
  }) {
    final questions = questionAnswerMap.entries
        .map(
          (e) => QuestionRequest(
            id: e.key,
            answers: e.value
                .map(
                  (answer) => AnswerRequest(
                    id: answer.id,
                    answer: answer.text,
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    return SubmitSurveyRequest(
      surveyId: surveyId,
      questions: questions,
    );
  }
}
