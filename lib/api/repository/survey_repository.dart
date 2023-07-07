import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/api/service/survey_service.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';

abstract class SurveyRepository {
  Future<SurveysResponse> getSurveys();

  Future<SurveyDetailResponse> getSurveyDetail(String surveyId);
}

@LazySingleton(as: SurveyRepository)
class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyService _surveyService;

  SurveyRepositoryImpl(this._surveyService);

  @override
  Future<SurveysResponse> getSurveys() {
    try {
      return _surveyService.getSurveys();
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
}
