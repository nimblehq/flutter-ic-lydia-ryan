import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/request/answer_request.dart';

part 'question_request.g.dart';

@JsonSerializable()
class QuestionRequest {
  final String id;
  final List<AnswerRequest> answers;

  QuestionRequest({
    required this.id,
    required this.answers,
  });

  factory QuestionRequest.fromJson(Map<String, dynamic> json) =>
      _$QuestionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionRequestToJson(this);
}
