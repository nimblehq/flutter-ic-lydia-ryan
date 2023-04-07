import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late LoginUseCase useCase;

    const email = "email";
    const password = "password";

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      useCase = LoginUseCase(mockAuthRepository);
    });

    test('When login is successful, it returns Success result', () async {
      final loginResponse = LoginResponse("", "", "", "", "");
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call(LoginInput(email, password));

      expect(result, isA<Success<LoginResponse>>());
    });

    test('When login is unsuccessful, it returns Failed result', () async {
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) => Future.error(Exception));

      final result = await useCase.call(LoginInput(email, password));

      expect(result, isA<Failed<LoginResponse>>());
    });
  });
}
