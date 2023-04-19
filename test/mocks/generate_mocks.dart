import 'package:dio/dio.dart';
import 'package:lydiaryanfluttersurvey/api/api_service.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/api/service/auth_service.dart';
import 'package:lydiaryanfluttersurvey/database/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<ApiService>(),
  MockSpec<AuthRepository>(),
  MockSpec<AuthService>(),
  MockSpec<DioError>(),
  MockSpec<UseCaseException>(),
  MockSpec<LoginUseCase>(),
  MockSpec<SharedPreferencesUtils>(),
])
main() {
  // empty class to generate mock repository classes
}
