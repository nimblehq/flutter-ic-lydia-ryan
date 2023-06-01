import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';

import 'question_response.dart';

part 'survey_detail_response.g.dart';

@JsonSerializable()
class SurveyDetailResponse {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final List<QuestionResponse> questions;

  SurveyDetailResponse(
    this.id,
    this.title,
    this.description,
    this.coverImageUrl,
    this.questions,
  );

  factory SurveyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyDetailResponseFromJson(fromJsonApi(json));
}
