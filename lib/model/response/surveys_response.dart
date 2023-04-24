import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_response.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveysResponse;

  SurveysResponse(
    this.surveysResponse,
  );

  factory SurveysResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysResponseFromJson(fromRootJsonApi(json));
}
