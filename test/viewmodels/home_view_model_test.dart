import 'package:flutter_test/flutter_test.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_state.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_view_model.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:mockito/mockito.dart';

import '../mocks/generate_mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('HomeViewModelTest', () {
    late MockGetSurveysUseCase mockGetUserUseCase;
    late HomeViewModel viewModel;

    setUp(() {
      mockGetUserUseCase = MockGetSurveysUseCase();
      viewModel = HomeViewModel(mockGetUserUseCase);
    });

    test('When getSurveys is successful, it emits success state', () async {
      final viewModelStream = viewModel.stream;
      final surveysResponse = SurveysResponse([], null);

      when(mockGetUserUseCase.call(any))
          .thenAnswer((_) async => Success(surveysResponse));

      expect(viewModelStream, emits(const HomeState.success()));

      viewModel.getSurveys();
    });

    test('When getSurveys is unsuccessful, it emits error state', () async {
      final viewModelStream = viewModel.stream;
      final mockException = MockUseCaseException();
      final actualException = Exception();

      when(mockException.actualException).thenReturn(actualException);
      when(mockGetUserUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));

      expect(
        viewModelStream,
        emitsInOrder([HomeState.error(actualException)]),
      );

      viewModel.getSurveys();
    });
  });
}
