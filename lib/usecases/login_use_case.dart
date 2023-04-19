import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

import '../database/shared_preferences_utils.dart';

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
  final SharedPreferencesUtils _sharedPreferenceUtils;

  LoginUseCase(this._authRepository, this._sharedPreferenceUtils);

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
    _sharedPreferenceUtils.setAccessToken(loginResponse.accessToken);
    _sharedPreferenceUtils.setRefreshToken(loginResponse.refreshToken);
  }
}
