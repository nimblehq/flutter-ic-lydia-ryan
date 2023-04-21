import 'package:flutter_test/flutter_test.dart';
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
    late MockVerifyLoggedInUseCase mockVerifyLoggedInUseCase;
    late LoginViewModel viewModel;

    const String email = 'email@email.com';
    const String password = '12345678';

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockVerifyLoggedInUseCase = MockVerifyLoggedInUseCase();
      viewModel = LoginViewModel(mockLoginUseCase, mockVerifyLoggedInUseCase);
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

      when(mockException.actualException).thenReturn(Exception(errorMessage));
      when(mockLoginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));

      expect(
          viewModelStream,
          emitsInOrder([
            const BaseViewModelState.loading(),
            BaseViewModelState.apiError(
                Failed(mockException).getErrorMessage()),
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

    test("When user logged in, isLoggedIn returns true", () async {
      when(mockVerifyLoggedInUseCase.call())
          .thenAnswer((_) async => Success(true));

      viewModel.isLoggedIn.listen(expectAsync1((value) {
        expect(value, true);
      }));

      viewModel.isLoggedIn;
    });

    test("When user did not log in, isLoggedIn returns false", () async {
      when(mockVerifyLoggedInUseCase.call())
          .thenAnswer((_) async => Success(false));

      viewModel.isLoggedIn.listen(expectAsync1((value) {
        expect(value, false);
      }));

      viewModel.isLoggedIn;
    });

    test("When VerifyLoggedInUseCase returns error, isLoggedIn returns false",
        () async {
      when(mockVerifyLoggedInUseCase.call())
          .thenAnswer((_) async => Failed(UseCaseException(Exception())));

      viewModel.isLoggedIn.listen(expectAsync1((value) {
        expect(value, false);
      }));

      viewModel.isLoggedIn;
    });
  });
}
