import 'package:dio/dio.dart';
import 'package:lydiaryanfluttersurvey/model/request/login_request.dart';
import 'package:lydiaryanfluttersurvey/model/request/refresh_token_request.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('/api/v1/oauth/token')
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST('/api/v1/oauth/token')
  Future<LoginResponse> refreshToken(@Body() RefreshTokenRequest request);
}
