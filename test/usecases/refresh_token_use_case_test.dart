import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/refresh_token_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockAuthRepository mockAuthRepository;
    late MockSharedPreferencesUtils mockSharedPreferencesUtils;
    late RefreshTokenUseCase useCase;

    const refreshToken = 'refreshToken';

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockSharedPreferencesUtils = MockSharedPreferencesUtils();
      useCase =
          RefreshTokenUseCase(mockAuthRepository, mockSharedPreferencesUtils);
    });

    test('When refreshToken is successful, it returns Success result',
        () async {
      final loginResponse = LoginResponse("", "", 0, "", 0);

      when(mockSharedPreferencesUtils.refreshToken).thenReturn(refreshToken);
      when(mockAuthRepository.refreshToken(refreshToken))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call();

      expect(result, isA<Success<LoginResponse>>());
    });

    test(
        'When refreshToken is successful, it saves accessToken to shared preferences',
        () async {
      final loginResponse = LoginResponse("accessToken", "", 0, "", 0);

      when(mockSharedPreferencesUtils.refreshToken).thenReturn(refreshToken);
      when(mockAuthRepository.refreshToken(refreshToken))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call();

      expect(result, isA<Success<LoginResponse>>());
      verify(
          mockSharedPreferencesUtils.setAccessToken(loginResponse.accessToken));
    });

    test(
        'When refreshToken is successful, it saves refreshToken to shared preferences',
        () async {
      final loginResponse = LoginResponse("", "", 0, refreshToken, 0);

      when(mockSharedPreferencesUtils.refreshToken).thenReturn(refreshToken);
      when(mockAuthRepository.refreshToken(refreshToken))
          .thenAnswer((_) async => loginResponse);

      final result = await useCase.call();

      expect(result, isA<Success<LoginResponse>>());
      verify(mockSharedPreferencesUtils
          .setRefreshToken(loginResponse.refreshToken));
    });

    test('When refreshToken is unsuccessful, it returns Failed result',
        () async {
      when(mockAuthRepository.refreshToken('refresh_token'))
          .thenAnswer((_) => Future.error(UseCaseException(Exception(''))));

      final result = await useCase.call();

      expect(result, isA<Failed<LoginResponse>>());
    });
  });
}
