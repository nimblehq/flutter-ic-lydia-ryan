import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';

import 'question_ui_model.dart';

class SurveyDetailUiModel {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final List<QuestionUiModel> questions;

  SurveyDetailUiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
  });

  String get largeCoverImageUrl => "${coverImageUrl}l";

  factory SurveyDetailUiModel.fromSurveyDetailsResponse(
      SurveyDetailResponse e) {
    return SurveyDetailUiModel(
      id: e.id ?? '',
      title: e.title ?? '',
      description: e.description ?? '',
      coverImageUrl: e.coverImageUrl ?? '',
      questions: e.questions
          .map((e) => QuestionUiModel.fromQuestionResponse(e))
          .toList(),
    );
  }
}
