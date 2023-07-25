import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/submit_survey_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('SubmitSurveyUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late SubmitSurveyUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = SubmitSurveyUseCase(mockSurveyRepository);
    });

    test('When SubmitSurveys is successful, it returns Success result',
        () async {
      when(mockSurveyRepository.submitSurvey(any)).thenAnswer((_) async => _);

      final result = await useCase.call(MockSubmitSurveyRequest());

      expect(result, isA<Success<void>>());
    });

    test('When SubmitSurveys is unsuccessful, it returns Failed result',
        () async {
      when(mockSurveyRepository.submitSurvey(any))
          .thenAnswer((_) => Future.error(UseCaseException(Exception(''))));

      final result = await useCase.call(MockSubmitSurveyRequest());

      expect(result, isA<Failed<void>>());
    });
  });
}
