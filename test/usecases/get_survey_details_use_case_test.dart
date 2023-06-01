import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_survey_details_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveyDetailsUseCaseTest', () {
    late MockSurveyRepository mockSurveyRepository;
    late GetSurveyDetailsUseCase useCase;

    setUp(() {
      mockSurveyRepository = MockSurveyRepository();
      useCase = GetSurveyDetailsUseCase(mockSurveyRepository);
    });

    test('When getSurveyDetails is successful, it returns Success result',
        () async {
      final surveyDetailResponse = MockSurveyDetailResponse();
      when(mockSurveyRepository.getSurveyDetails('1'))
          .thenAnswer((_) async => surveyDetailResponse);

      final result = await useCase.call('1');

      expect(result, isA<Success<SurveyDetailResponse>>());
    });

    test('When getSurveyDetails is unsuccessful, it returns Failed result',
        () async {
      when(mockSurveyRepository.getSurveyDetails('1'))
          .thenAnswer((_) => Future.error(UseCaseException(Exception(''))));

      final result = await useCase.call('1');

      expect(result, isA<Failed<SurveyDetailResponse>>());
    });
  });
}
