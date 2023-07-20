import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_detail_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/survey_detail_state.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

import 'package:lydiaryanfluttersurvey/usecases/get_survey_detail_use_case.dart';
import 'package:rxdart/subjects.dart';

class SurveyDetailViewModel extends StateNotifier<SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetailUseCase;

  final BehaviorSubject<SurveyDetailUiModel> _surveyDetail = BehaviorSubject();
  Stream<SurveyDetailUiModel> get surveyDetail => _surveyDetail.stream;

  final Map<String, List<AnswerUiModel>> _surveyAnswers = {};

  SurveyDetailViewModel(this._getSurveyDetailUseCase)
      : super(const SurveyDetailState.init());

  Future<void> getSurveyDetail(String surveyId) async {
    final result = await _getSurveyDetailUseCase.call(surveyId);

    if (result is Success<SurveyDetailResponse>) {
      final response = result.value;
      _surveyDetail.add(SurveyDetailUiModel.fromSurveyDetailResponse(response));
      state = const SurveyDetailState.success();
    } else if (result is Failed<SurveyDetailResponse>) {
      final exception = result.exception.actualException;
      state = SurveyDetailState.error(exception);
    }
  }

  void setAnswer(String questionId, List<AnswerUiModel> answer) {
    _surveyAnswers[questionId] = answer;
  }

  void submitSurvey() {
    // TODO
  }

  @override
  void dispose() {
    _surveyDetail.close();
    super.dispose();
  }
}
