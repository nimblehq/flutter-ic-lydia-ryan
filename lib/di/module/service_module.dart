import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/service/auth_service.dart';
import 'package:lydiaryanfluttersurvey/di/provider/dio_provider.dart';
import 'package:lydiaryanfluttersurvey/env.dart';

@module
abstract class ServiceModule {
  @Singleton()
  AuthService provideAuthService(DioProvider dioProvider) =>
      AuthService(dioProvider.getDio(), baseUrl: Env.restApiEndpoint);
}
