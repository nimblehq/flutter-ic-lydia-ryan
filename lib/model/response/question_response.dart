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

enum PickType {
  @JsonValue('none')
  none,
  @JsonValue('one')
  single,
  @JsonValue('any')
  multiple,
  unknown
}

@JsonSerializable()
class QuestionResponse {
  final String? id;
  final String? text;
  final DisplayType? displayType;
  final PickType? pick;
  final List<AnswerResponse>? answers;

  QuestionResponse(
    this.id,
    this.text,
    this.displayType,
    this.pick,
    this.answers,
  );

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(json);
}
