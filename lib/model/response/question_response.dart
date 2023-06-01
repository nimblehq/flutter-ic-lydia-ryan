import 'package:json_annotation/json_annotation.dart';

import 'answer_response.dart';

part 'question_response.g.dart';

enum DisplayType {
  intro,
  choice,
  dropdown,
  heart,
  nps,
  outro,
  smiley,
  star,
  textarea,
  textfield,
  thumbs,
  unknown
}

@JsonSerializable()
class QuestionResponse {
  final String? id;
  final String? text;
  final DisplayType? displayType;
  final List<AnswerResponse>? answers;

  QuestionResponse(
    this.id,
    this.text,
    this.displayType,
    this.answers,
  );

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);
}
