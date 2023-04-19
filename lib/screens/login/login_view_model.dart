import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/base/base_view_model_state.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';

class LoginViewModel extends StateNotifier<BaseViewModelState> {
  LoginViewModel(
    this._loginUseCase,
    this._sharedPreferencesUtils,
  ) : super(const BaseViewModelState.init()) {
    _accessToken = _sharedPreferencesUtils.accessToken ?? "";
    _refreshToken = _sharedPreferencesUtils.refreshToken ?? "";
  }

  final LoginUseCase _loginUseCase;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  late String _accessToken;
  late String _refreshToken;

  bool isLoggedIn() => _accessToken.isNotEmpty && _refreshToken.isNotEmpty;

  void login(String email, String password) async {
    state = const BaseViewModelState.loading();

    if (!_validateInputs(email, password)) {
      state = const BaseViewModelState.invalidInputsError();
      return;
    }

    Result<void> result = await _loginUseCase.call(
      LoginInput(email: email, password: password),
    );
    if (result is Success) {
      state = const BaseViewModelState.success();
    } else {
      state = BaseViewModelState.apiError((result as Failed).getErrorMessage());
    }
  }

  bool _validateInputs(String email, String password) {
    final isEmailValid = EmailValidator.validate(email);
    final isPasswordValid = password.isNotEmpty && password.length >= 8;
    return isEmailValid && isPasswordValid;
  }
}
