import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_model_state.freezed.dart';

@freezed
class HomeViewModelState with _$HomeViewModelState {
  const factory HomeViewModelState.init() = _Init;

  const factory HomeViewModelState.loading() = _Loading;

  const factory HomeViewModelState.success() = _Success;

  const factory HomeViewModelState.apiError(String errorMessage) = _ApiError;
}
