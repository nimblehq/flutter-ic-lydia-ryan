import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_detail_state.freezed.dart';

@freezed
class SurveyDetailState with _$SurveyDetailState {
  const factory SurveyDetailState.init() = _Init;
  const factory SurveyDetailState.success() = _Success;
  const factory SurveyDetailState.submitting() = _Submitting;
  const factory SurveyDetailState.submitted() = _Submitted;
  const factory SurveyDetailState.error(Exception exception) = _Error;
}
