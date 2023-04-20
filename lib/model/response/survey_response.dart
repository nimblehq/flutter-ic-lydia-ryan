import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final String id;
  final String title;
  final String description;
  final String thankEmailAboveThreshold;
  final String thankEmailBelowThreshold;
  final bool isActive;
  final String coverImageUrl;
  final String createdAt;
  final String activeAt;
  final String inactiveAt;
  final String surveyType;

  SurveyResponse(
    this.id,
    this.title,
    this.description,
    this.thankEmailAboveThreshold,
    this.thankEmailBelowThreshold,
    this.isActive,
    this.coverImageUrl,
    this.createdAt,
    this.activeAt,
    this.inactiveAt,
    this.surveyType,
  );

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);
}
