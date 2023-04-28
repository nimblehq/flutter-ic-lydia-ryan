import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesUtils {
  String get refreshToken;

  String get accessToken;

  String get tokenType;

  String get headerAuthorization;

  bool get isLoggedIn;

  void setRefreshToken(String? value);

  void setAccessToken(String? value);

  void setTokenType(String? tokenType);
}

@Singleton(as: SharedPreferencesUtils)
class SharedPreferencesUtilsImpl implements SharedPreferencesUtils {
  SharedPreferencesUtilsImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  String get accessToken => _sharedPreferences.getString('access_token') ?? '';

  @override
  String get refreshToken =>
      _sharedPreferences.getString('refresh_token') ?? '';

  @override
  String get tokenType => _sharedPreferences.getString('token_type') ?? '';

  @override
  String get headerAuthorization => '$tokenType $accessToken';

  @override
  bool get isLoggedIn => accessToken.isNotEmpty && refreshToken.isNotEmpty;

  @override
  void setRefreshToken(String? value) async {
    await _sharedPreferences.setString('refresh_token', value ?? '');
  }

  @override
  void setAccessToken(String? value) async {
    await _sharedPreferences.setString('access_token', value ?? '');
  }

  @override
  void setTokenType(String? tokenType) async {
    await _sharedPreferences.setString('token_type', tokenType ?? '');
  }
}
