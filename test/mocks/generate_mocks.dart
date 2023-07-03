import 'package:dio/dio.dart';
import 'package:lydiaryanfluttersurvey/api/api_service.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/api/repository/survey_repository.dart';
import 'package:lydiaryanfluttersurvey/api/service/auth_service.dart';
import 'package:lydiaryanfluttersurvey/api/service/survey_service.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_surveys_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<ApiService>(),
  MockSpec<AuthRepository>(),
  MockSpec<SurveyRepository>(),
  MockSpec<AuthService>(),
  MockSpec<SurveyService>(),
  MockSpec<DioError>(),
  MockSpec<SharedPreferencesUtils>(),
  MockSpec<UseCaseException>(),
  MockSpec<LoginUseCase>(),
  MockSpec<GetSurveysUseCase>(),
  MockSpec<SurveyDetailResponse>(),
])
main() {
  // empty class to generate mock repository classes
}
