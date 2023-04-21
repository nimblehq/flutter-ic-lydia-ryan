import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/base/base_view_model_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/verify_logged_in_use_case.dart';

class LoginViewModel extends StateNotifier<BaseViewModelState> {
  final LoginUseCase _loginUseCase;
  final VerifyLoggedInUseCase _verifyLoggedInUseCase;

  Stream<bool> get isLoggedIn => _verifyLoggedIn().asStream();

  LoginViewModel(
    this._loginUseCase,
    this._verifyLoggedInUseCase,
  ) : super(const BaseViewModelState.init());

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

  Future<bool> _verifyLoggedIn() async {
    Result<void> result = await _verifyLoggedInUseCase.call();
    if (result is Success) {
      return result.value;
    }

    return false;
  }
}
