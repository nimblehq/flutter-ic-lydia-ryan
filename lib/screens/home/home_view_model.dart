import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_surveys_use_case.dart';
import 'package:rxdart/subjects.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final GetSurveysUseCase _getSurveysUseCase;

  final BehaviorSubject<List<SurveyUiModel>> _surveys = BehaviorSubject();
  Stream<List<SurveyUiModel>> get surveys => _surveys.stream;

  final BehaviorSubject<String> _error = BehaviorSubject();
  Stream<String> get error => _error.stream;

  HomeViewModel(this._getSurveysUseCase) : super(const HomeState.init());

  Future<void> getSurveys() async {
    final result = await _getSurveysUseCase.call();

    if (result is Success<SurveysResponse>) {
      final surveys = result.value.surveysResponse
          .map((e) => SurveyUiModel.fromSurveyResponse(e))
          .toList();
      _surveys.add(surveys);
      state = const HomeState.success();
    } else if (result is Failed<SurveysResponse>) {
      _error.add(result.exception.actualException.toString());
      state = const HomeState.error();
    }
  }
}
