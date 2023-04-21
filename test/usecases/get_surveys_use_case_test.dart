import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_surveys_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveysUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late GetSurveysUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = GetSurveysUseCase(mockSurveyRepository);
    });

    test('When getSurveys is successful, it returns Success result', () async {
      final surveysResponse = SurveysResponse([]);
      when(mockSurveyRepository.getSurveys())
          .thenAnswer((_) async => surveysResponse);

      final result = await useCase.call();

      expect(result, isA<Success<SurveysResponse>>());
    });

    test('When getSurveys is unsuccessful, it returns Failed result', () async {
      when(mockSurveyRepository.getSurveys())
          .thenAnswer((_) => Future.error(UseCaseException(Exception(''))));

      final result = await useCase.call();

      expect(result, isA<Failed<SurveysResponse>>());
    });
  });
}
