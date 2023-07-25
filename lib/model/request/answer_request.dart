import 'package:json_annotation/json_annotation.dart';

part 'answer_request.g.dart';

@JsonSerializable()
class AnswerRequest {
  final String id;
  final String? answer;

  AnswerRequest({required this.id, this.answer});

  factory AnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$AnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerRequestToJson(this);
}
