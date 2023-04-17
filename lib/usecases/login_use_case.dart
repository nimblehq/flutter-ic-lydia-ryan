import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/exception/network_exceptions.dart';
import 'package:lydiaryanfluttersurvey/api/repository/auth_repository.dart';
import 'package:lydiaryanfluttersurvey/model/response/login_response.dart';
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

  LoginUseCase(this._authRepository);

  @override
  Future<Result<LoginResponse>> call(LoginInput params) {
    return _authRepository
        .login(params.email, params.password)
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<LoginResponse>)
        .onError<NetworkExceptions>(
            (error, stackTrace) => Failed(UseCaseException(error)));
  }
}
