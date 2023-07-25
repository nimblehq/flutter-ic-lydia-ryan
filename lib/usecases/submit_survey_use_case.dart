import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/repository/survey_repository.dart';
import 'package:lydiaryanfluttersurvey/model/request/submit_survey_request.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

@Injectable()
class SubmitSurveyUseCase extends UseCase<void, SubmitSurveyRequest> {
  final SurveyRepository _surveyRepository;

  SubmitSurveyUseCase(this._surveyRepository);

  @override
  Future<Result<void>> call(SubmitSurveyRequest params) {
    return _surveyRepository
        .submitSurvey(params)
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<void>)
        .onError<Exception>(
            (error, stackTrace) => Failed(UseCaseException(error)));
  }
}
