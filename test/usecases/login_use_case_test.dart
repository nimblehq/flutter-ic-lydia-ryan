import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late MockSharedPreferencesUtils mockSharedPreferencesUtils;
    late LoginUseCase useCase;

    const email = "email@email.com";
    const password = "password";

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockSharedPreferencesUtils = MockSharedPreferencesUtils();
      useCase = LoginUseCase(mockAuthRepository, mockSharedPreferencesUtils);
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

    test('When login is successful, it saves accessToken to shared preferences',
        () async {
      final loginResponse = LoginResponse("accessToken", "", 0, "", 0);
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call(LoginInput(
        email: email,
        password: password,
      ));

      expect(result, isA<Success<LoginResponse>>());
      verify(
          mockSharedPreferencesUtils.setAccessToken(loginResponse.accessToken));
    });

    test(
        'When login is successful, it saves refreshToken to shared preferences',
        () async {
      final loginResponse = LoginResponse("", "", 0, "refreshToken", 0);
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call(LoginInput(
        email: email,
        password: password,
      ));

      expect(result, isA<Success<LoginResponse>>());
      verify(mockSharedPreferencesUtils
          .setRefreshToken(loginResponse.refreshToken));
    });

    test('When login is successful, it saves tokenType to shared preferences',
        () async {
      final loginResponse = LoginResponse("", "tokenType", 0, "", 0);
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call(LoginInput(
        email: email,
        password: password,
      ));

      expect(result, isA<Success<LoginResponse>>());
      verify(mockSharedPreferencesUtils.setTokenType(loginResponse.tokenType));
    });

    test('When login is unsuccessful, it returns Failed result', () async {
      when(mockAuthRepository.login(email, password))
          .thenAnswer((_) => Future.error(UseCaseException(Exception(''))));

      final result = await useCase.call(LoginInput(
        email: email,
        password: password,
      ));

      expect(result, isA<Failed<LoginResponse>>());
    });
  });
}
