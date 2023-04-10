import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_view_model_state.freezed.dart';

@freezed
class BaseViewModelState with _$BaseViewModelState {
  const factory BaseViewModelState.init() = _Init;

  const factory BaseViewModelState.loading() = _Loading;

  const factory BaseViewModelState.success() = _Success;

  const factory BaseViewModelState.apiError(String errorMessage) = _ApiError;

  const factory BaseViewModelState.invalidInputsError() = _InvalidInputsError;
}