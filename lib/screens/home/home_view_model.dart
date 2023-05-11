import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_surveys_use_case.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel(this._getSurveysUseCase) : super(const HomeState.init());

  void getSurveys() async {
    state = const HomeState.loading();
    final result = await _getSurveysUseCase.call();

    if (result is Success<SurveysResponse>) {
      final surveys = result.value.surveysResponse
          .map((e) => SurveyUiModel.fromSurveyResponse(e))
          .toList();
      state = HomeState.success(surveys);
    } else if (result is Failed<SurveysResponse>) {
      final error = result.exception;
      state = HomeState.error(error.toString());
    }
  }
}
