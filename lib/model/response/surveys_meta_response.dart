import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';

part 'surveys_meta_response.g.dart';

@JsonSerializable()
class SurveysMetaResponse {
  final int? page;
  final int? pages;
  final int? pageSize;
  final int? records;

  SurveysMetaResponse(
    this.page,
    this.pages,
    this.pageSize,
    this.records,
  );

  factory SurveysMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveysMetaResponseFromJson(fromJsonApi(json));
}
