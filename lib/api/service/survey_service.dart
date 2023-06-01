import 'package:dio/dio.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:retrofit/retrofit.dart';

part 'survey_service.g.dart';

@RestApi()
abstract class SurveyService {
  factory SurveyService(Dio dio, {String baseUrl}) = _SurveyService;

  @GET('/api/v1/surveys')
  Future<SurveysResponse> getSurveys();

  @GET('/surveys/{surveyId}')
  Future<SurveyDetailResponse> getSurveyDetail(
    @Path('surveyId') String surveyId,
  );
}
