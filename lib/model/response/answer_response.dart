import 'package:json_annotation/json_annotation.dart';

part 'answer_response.g.dart';

@JsonSerializable()
class AnswerResponse {
  final String id;
  final String? text;

  AnswerResponse(
    this.id,
    this.text,
  );

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(json);
}
