import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_response.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_meta_response.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveysResponse;
  @JsonKey(name: 'meta')
  final SurveysMetaResponse? metaResponse;

  SurveysResponse(
    this.surveysResponse,
    this.metaResponse,
  );

  factory SurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysResponseFromJson(fromRootJsonApi(json));
}
