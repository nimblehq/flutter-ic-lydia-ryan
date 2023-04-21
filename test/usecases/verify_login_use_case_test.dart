import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/verify_logged_in_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('VerifyLoginUseCaseTest', () {
    late MockSharedPreferencesUtils mockSharedPreferencesUtils;

    setUp(() {
      mockSharedPreferencesUtils = MockSharedPreferencesUtils();
    });

    test('When user logged in and tokens are persisted, it returns true',
        () async {
      when(mockSharedPreferencesUtils.accessToken).thenReturn('accessToken');
      when(mockSharedPreferencesUtils.refreshToken).thenReturn('refreshToken');

      var useCase = VerifyLoggedInUseCase(mockSharedPreferencesUtils);

      final result = await useCase.call();

      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).value, true);
    });

    test(
        'When user logged in or any tokens are not persisted, it returns false',
        () async {
      when(mockSharedPreferencesUtils.accessToken).thenReturn('accessToken');
      when(mockSharedPreferencesUtils.refreshToken).thenReturn('');

      var useCase = VerifyLoggedInUseCase(mockSharedPreferencesUtils);

      final result = await useCase.call();

      expect(result, isA<Success<bool>>());
      expect((result as Success<bool>).value, false);
    });
  });
}
