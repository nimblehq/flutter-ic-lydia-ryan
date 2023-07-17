import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_surveys_use_case.dart';
import 'package:rxdart/subjects.dart';

const _pageSize = 10;

class HomeViewModel extends StateNotifier<HomeState> {
  final GetSurveysUseCase _getSurveysUseCase;

  final BehaviorSubject<List<SurveyUiModel>> _surveys = BehaviorSubject();
  Stream<List<SurveyUiModel>> get surveys => _surveys.stream;

  // TODO: Update this value in integrate ticket
  final int _currentPage = 1;

  HomeViewModel(this._getSurveysUseCase) : super(const HomeState.init());

  Future<void> getSurveys() async {
    final getSurveysInput = GetSurveysInput(_currentPage, _pageSize);
    final result = await _getSurveysUseCase.call(getSurveysInput);

    if (result is Success<SurveysResponse>) {
      final surveys = result.value.surveysResponse
          .map((response) => SurveyUiModel.fromSurveyResponse(response))
          .toList();
      _surveys.add(surveys);
      state = const HomeState.success();
    } else if (result is Failed<SurveysResponse>) {
      final exception = result.exception.actualException;
      state = HomeState.error(exception);
    }
  }
}
