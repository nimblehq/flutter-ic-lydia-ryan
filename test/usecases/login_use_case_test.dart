import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late LoginUseCase useCase;

    const email = "email@email.com";
    const password = "password";

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      useCase = LoginUseCase(mockAuthRepository);
    });

    test('When login is successful, it returns Success result', () async {
      final loginResponse = LoginResponse("", "", 0, "", 0);
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call(LoginInput(
        email: email,
        password: password,
      ));

      expect(result, isA<Success<LoginResponse>>());
    });

    test('When login is unsuccessful, it returns Failed result', () async {
      when(mockAuthRepository.login(email, password)).thenAnswer(
          (_) => Future.error(const NetworkExceptions.badRequest()));

      final result = await useCase.call(LoginInput(
        email: email,
        password: password,
      ));

      expect(result, isA<Failed<LoginResponse>>());
    });
  });
}
