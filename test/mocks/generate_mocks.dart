import 'package:dio/dio.dart';
import 'package:lydiaryanfluttersurvey/api/api_service.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/api/service/auth_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ApiService,
  AuthRepository,
  AuthService,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
