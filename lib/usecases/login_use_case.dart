import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

class LoginInput {
  final String email;
  final String password;

  LoginInput({
    required this.email,
    required this.password,
  });
}

@Injectable()
class LoginUseCase extends UseCase<LoginResponse, LoginInput> {
  final AuthRepository _authRepository;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  LoginUseCase(this._authRepository, this._sharedPreferencesUtils);

  @override
  Future<Result<LoginResponse>> call(LoginInput params) {
    return _authRepository.login(params.email, params.password).then((value) {
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
