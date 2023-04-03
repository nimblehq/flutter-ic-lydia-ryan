import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/api/service/auth_service.dart';
import 'package:lydiaryanfluttersurvey/constants.dart';
import 'package:lydiaryanfluttersurvey/env.dart';
import 'package:lydiaryanfluttersurvey/model/request/login_request.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(String username, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<LoginResponse> login(String username, String password) {
    LoginRequest loginRequest = LoginRequest(
      grantType: Constants.auth.grantType,
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
}
