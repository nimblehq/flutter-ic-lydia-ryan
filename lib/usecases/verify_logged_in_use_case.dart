import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

@Injectable()
class VerifyLoggedInUseCase extends NoParamsUseCase<bool> {
  VerifyLoggedInUseCase(this._sharedPreferencesUtils) {
    _accessToken = _sharedPreferencesUtils.accessToken;
    _refreshToken = _sharedPreferencesUtils.refreshToken;
  }

  final SharedPreferencesUtils _sharedPreferencesUtils;
  late String _accessToken;
  late String _refreshToken;

  @override
  Future<Result<bool>> call() {
    Result<bool> result =
        Success(_accessToken.isNotEmpty && _refreshToken.isNotEmpty);

    return Future.value(result).then((value) => value);
  }
}
