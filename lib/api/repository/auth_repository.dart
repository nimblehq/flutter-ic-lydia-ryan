import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/api/service/auth_service.dart';
import 'package:lydiaryanfluttersurvey/constants.dart';
import 'package:lydiaryanfluttersurvey/env.dart';
import 'package:lydiaryanfluttersurvey/model/request/login_request.dart';
import 'package:lydiaryanfluttersurvey/model/request/refresh_token_request.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String username, String password);

  Future<LoginResponse> refreshToken(String refreshToken);
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<LoginResponse> login(String username, String password) {
    LoginRequest loginRequest = LoginRequest(
      grantType: Constants.auth.grantTypePassword,
      email: username,
      password: password,
      clientId: Env.authClientId,
      clientSecret: Env.authClientSecret,
    );

    try {
      return _authService.login(loginRequest);
    } catch (e) {
      return Future.error(NetworkExceptions.fromDioException(e));
    }
  }

  @override
  Future<LoginResponse> refreshToken(String refreshToken) {
    RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(
      grantType: Constants.auth.grantTypeRefreshToken,
      refreshToken: refreshToken,
      clientId: Env.authClientId,
      clientSecret: Env.authClientSecret,
    );

    try {
      return _authService.refreshToken(refreshTokenRequest);
    } catch (e) {
      return Future.error(NetworkExceptions.fromDioException(e));
    }
  }
}
