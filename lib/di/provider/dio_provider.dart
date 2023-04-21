import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/di/injection.dart';
import 'package:lydiaryanfluttersurvey/di/interceptor/app_interceptor.dart';
import 'package:lydiaryanfluttersurvey/env.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';

@Singleton()
class DioProvider {
  Dio? _nonAuthenticatedDio;
  Dio? _authenticatedDio;

  Dio getNonAuthenticatedDio() {
    _nonAuthenticatedDio ??= _createDio();
    return _nonAuthenticatedDio!;
  }

  Dio getAuthenticatedDio() {
    _authenticatedDio ??= _createDio(requireAuthentication: true);
    return _authenticatedDio!;
  }

  Dio _createDio({bool requireAuthentication = false}) {
    final dio = Dio();
    final SharedPreferencesUtils sharedPreferencesUtils =
        getIt<SharedPreferencesUtils>();
    final appInterceptor = AppInterceptor(
      requireAuthentication,
      dio,
      sharedPreferencesUtils,
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {headerContentType: defaultContentType}
      ..options.baseUrl = Env.restApiEndpoint
      ..interceptors.addAll(interceptors);
  }
}
