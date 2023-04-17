import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/base/base_view_model_state.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/screens/login/login_view_model.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LoginViewModelTest', () {
    late MockLoginUseCase mockLoginUseCase;
    late LoginViewModel viewModel;

    const String email = 'email@email.com';
    const String password = '12345678';

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      viewModel = LoginViewModel(mockLoginUseCase);
    });

    test('When login is successful, it emits loading and success state orderly',
        () async {
      final viewModelStream = viewModel.stream;
      final loginResponse = LoginResponse("", "", 0, "", 0);

      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Success(loginResponse));

      expect(
          viewModelStream,
          emitsInOrder([
            const BaseViewModelState.loading(),
            const BaseViewModelState.success(),
          ]));

      viewModel.login(email, password);
    });

    test(
        'When login is unsuccessful, it emits loading and apiError state orderly',
        () async {
      final viewModelStream = viewModel.stream;
      final mockException = MockUseCaseException();
      const errorMessage = 'Error message';

      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.defaultError(errorMessage));
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));

      expect(
          viewModelStream,
          emitsInOrder([
            const BaseViewModelState.loading(),
            const BaseViewModelState.apiError('Error message'),
          ]));

      viewModel.login(email, password);
    });

    test(
        'When input is incorrect, it emits loading and invalidInputsError state orderly',
        () async {
      final viewModelStream = viewModel.stream;
      final loginResponse = LoginResponse("", "", 0, "", 0);

      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Success(loginResponse));

      expect(
          viewModelStream,
          emitsInOrder([
            const BaseViewModelState.loading(),
            const BaseViewModelState.invalidInputsError(),
          ]));

      viewModel.login('invalidEmail', ' ');
    });

    test('When input is incorrect, it has never called LoginUseCase', () async {
      final loginResponse = LoginResponse("", "", 0, "", 0);

      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Success(loginResponse));

      verifyNever(mockLoginUseCase.call(any));

      viewModel.login('invalidEmail', ' ');
    });
  });
}
