import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/api/service/survey_service.dart';
import 'package:lydiaryanfluttersurvey/model/request/submit_survey_request.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';

abstract class SurveyRepository {
  Future<SurveysResponse> getSurveys({
    required int pageNumber,
    required int pageSize,
  });

  Future<SurveyDetailResponse> getSurveyDetail(String surveyId);

  Future<void> submitSurvey(SubmitSurveyRequest submitSurveyRequest);
}

@LazySingleton(as: SurveyRepository)
class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<SurveysResponse> getSurveys({
    required int pageNumber,
    required int pageSize,
  }) {
    try {
      return _surveyService.getSurveys(pageNumber, pageSize);
    } catch (e) {
      return Future.error(NetworkExceptions.fromDioException(e));
    }
  }

  @override
  Future<SurveyDetailResponse> getSurveyDetail(String surveyId) {
    try {
      return _surveyService.getSurveyDetail(surveyId);
    } catch (e) {
      return Future.error(NetworkExceptions.fromDioException(e));
    }
  }

  @override
  Future<void> submitSurvey(SubmitSurveyRequest submitSurveyRequest) {
    try {
      return _surveyService.submitSurvey(submitSurveyRequest);
    } catch (e) {
      return Future.error(NetworkExceptions.fromDioException(e));
    }
  }
}
