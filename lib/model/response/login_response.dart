import 'package:json_annotation/json_annotation.dart';
import 'package:lydiaryanfluttersurvey/model/response/converter/response_converter.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String grantType;
  final String email;
  final String password;
  final String clientId;
  final String clientSecret;

  LoginResponse(this.grantType, this.email, this.password, this.clientId,
      this.clientSecret);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(mapDataJson(json));

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
