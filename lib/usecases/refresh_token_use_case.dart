import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/database/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

@Injectable()
class RefreshTokenUseCase extends NoParamsUseCase<LoginResponse> {
  final AuthRepository _authRepository;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  RefreshTokenUseCase(this._authRepository, this._sharedPreferencesUtils);

  @override
  Future<Result<LoginResponse>> call() async {
    String refreshToken = _sharedPreferencesUtils.refreshToken ?? "";
    if (refreshToken.isEmpty) {
      return Failed(UseCaseException(Exception("Refresh token is empty")));
    }

    return _authRepository.refreshToken(refreshToken).then((value) {
      _saveToken(value);
      // ignore: unnecessary_cast
      return Success(value) as Result<LoginResponse>;
    }).onError<Exception>(
        (error, stackTrace) => Failed(UseCaseException(error)));
  }

  void _saveToken(LoginResponse loginResponse) {
    _sharedPreferencesUtils.setAccessToken(loginResponse.accessToken);
    _sharedPreferencesUtils.setRefreshToken(loginResponse.refreshToken);
  }
}
