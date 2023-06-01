import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_detail_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/survey_detail_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

import 'package:lydiaryanfluttersurvey/usecases/get_survey_detail_use_case.dart';
import 'package:rxdart/subjects.dart';

class SurveyDetailViewModel extends StateNotifier<SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetailsUseCase;

  final BehaviorSubject<SurveyDetailUiModel> _surveyDetail = BehaviorSubject();
  Stream<SurveyDetailUiModel> get surveyDetail => _surveyDetail.stream;

  SurveyDetailViewModel(this._getSurveyDetailsUseCase)
      : super(const SurveyDetailState.init());

  Future<void> getSurveyDetail(String surveyId) async {
    final result = await _getSurveyDetailsUseCase.call(surveyId);

    if (result is Success<SurveyDetailResponse>) {
      final response = result.value;
      _surveyDetail
          .add(SurveyDetailUiModel.fromSurveyDetailsResponse(response));
      state = const SurveyDetailState.success();
    } else if (result is Failed<SurveyDetailResponse>) {
      final exception = result.exception.actualException;
      state = SurveyDetailState.error(exception);
    }
  }
}
