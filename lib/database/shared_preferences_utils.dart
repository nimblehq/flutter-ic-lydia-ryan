import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesUtils {
  String? get refreshToken;

  String? get accessToken;

  void setRefreshToken(String? value);

  void setAccessToken(String? value);
}

class SharedPreferencesUtilsImpl implements SharedPreferencesUtils {
  SharedPreferencesUtilsImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  String? get accessToken => _sharedPreferences.getString('access_token');

  @override
  String? get refreshToken => _sharedPreferences.getString('refresh_token');

  @override
  void setRefreshToken(String? value) async {
    await _sharedPreferences.setString('refresh_token', value ?? '');
  }

  @override
  void setAccessToken(String? value) {
    _sharedPreferences.setString('access_token', value ?? '');
  }
}
