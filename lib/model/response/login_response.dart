import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final int createdAt;

  LoginResponse(
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.createdAt,
  );

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(fromJsonApi(json));
}
