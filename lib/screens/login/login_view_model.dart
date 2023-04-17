import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/base/base_view_model_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';

import '../../usecases/base/base_use_case.dart';
import '../../utils/toast_message.dart';

class LoginViewModel extends StateNotifier<BaseViewModelState> {
  LoginViewModel(this._loginUseCase) : super(const BaseViewModelState.init());

  final LoginUseCase _loginUseCase;

  void login(String email, String password) async {
    state = const BaseViewModelState.loading();
    if (_validateInputs(email, password)) {
      Result<void> result = await _loginUseCase.call(
        LoginInput(
          email: email,
          password: password,
        ),
      );
      if (result is Success) {
        state = const BaseViewModelState.success();
        showToast('Login success');
      } else {
        state =
            BaseViewModelState.apiError((result as Failed).getErrorMessage());
        showToast('Login Failed: $state');
      }
    } else {
      state = const BaseViewModelState.invalidInputsError();
    }
  }

  bool _validateInputs(String email, String password) {
    final isEmailValid = EmailValidator.validate(email);
    final isPasswordValid = password.isNotEmpty && password.length >= 8;
    return isEmailValid && isPasswordValid;
  }
}
