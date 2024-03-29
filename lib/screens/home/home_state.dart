import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.init() = _Init;
  const factory HomeState.success() = _Success;
  const factory HomeState.error(Exception exception) = _Error;
}
