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
  Dio? _dio;

  Dio getDio() {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final SharedPreferencesUtils sharedPreferencesUtils =
        getIt<SharedPreferencesUtils>();
    final appInterceptor = AppInterceptor(
      requireAuthenticate,
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
