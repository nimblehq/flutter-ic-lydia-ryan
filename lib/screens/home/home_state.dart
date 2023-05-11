import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.init() = _Init;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.success(List<SurveyUiModel> surveys) = _Success;
  const factory HomeState.error(String message) = _Error;
}
