import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/generate_mocks.mocks.dart';

void main() {
  FlutterConfig.loadValueForTesting({
    'KEY': 'KEY',
    'SECRET': 'SECRET',
  });

  group('AuthRepositoryImplTest', () {
    late MockAuthService mockAuthService;
    late AuthRepositoryImpl authRepository;

    const email = "email";
    const password = "password";

    setUp(() {
      mockAuthService = MockAuthService();
      authRepository = AuthRepositoryImpl(mockAuthService);
    });

    test('When calling login successfully, it returns LoginResponse', () async {
      final loginResponse = LoginResponse("", "", 0, "", 0);

      when(mockAuthService.login(any)).thenAnswer((_) async => loginResponse);

      final result = await authRepository.login(email, password);

      expect(result, loginResponse);
    });

    test(
        'When calling login unsuccessfully, it returns Failed NetworkExceptions',
        () async {
      when(mockAuthService.login(any)).thenThrow(Exception());

      final result = authRepository.login(email, password);

      expect(result, throwsA(isA<NetworkExceptions>()));
    });
  });
}
