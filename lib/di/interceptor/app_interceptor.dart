import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lydiaryanfluttersurvey/di/injection.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';
import 'package:lydiaryanfluttersurvey/usecases/refresh_token_use_case.dart';

const _headerAuthorization = 'Authorization';

class AppInterceptor extends Interceptor {
  final bool _requireAuthenticate;
  final Dio _dio;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  AppInterceptor(
    this._requireAuthenticate,
    this._dio,
    this._sharedPreferencesUtils,
  );

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (_requireAuthenticate) {
      options.headers.putIfAbsent(_headerAuthorization, () => "");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthenticate) {
      _doRefreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _doRefreshToken(
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final RefreshTokenUseCase refreshTokenUseCase =
          getIt<RefreshTokenUseCase>();
      final result = await refreshTokenUseCase.call();
      if (result is Success<LoginResponse>) {
        // Update new token header
        final newAuthToken =
            result.value.tokenType + _sharedPreferencesUtils.accessToken;
        error.requestOptions.headers[_headerAuthorization] = newAuthToken;

        // Create request with new access token
        final options = Options(
            method: error.requestOptions.method,
            headers: error.requestOptions.headers);
        final newRequest = await _dio.request(
            "${error.requestOptions.baseUrl}${error.requestOptions.path}",
            options: options,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters);
        handler.resolve(newRequest);
      } else {
        handler.next(error);
      }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(error);
      }
    }
  }
}
