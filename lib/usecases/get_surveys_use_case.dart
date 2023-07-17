import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/repository/survey_repository.dart';
import 'package:lydiaryanfluttersurvey/model/response/surveys_response.dart';
import 'package:lydiaryanfluttersurvey/usecases/base/base_use_case.dart';

@Injectable()
class GetSurveysUseCase extends UseCase<SurveysResponse, GetSurveysInput> {
  final SurveyRepository _surveyRepository;

  GetSurveysUseCase(this._surveyRepository);

  @override
  Future<Result<SurveysResponse>> call(GetSurveysInput params) {
    return _surveyRepository
        .getSurveys(
          pageNumber: params.pageNumber,
          pageSize: params.pageSize,
        )
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<SurveysResponse>)
        .onError<Exception>(
            (error, stackTrace) => Failed(UseCaseException(error)));
  }
}

class GetSurveysInput {
  final int pageNumber;
  final int pageSize;

  GetSurveysInput(this.pageNumber, this.pageSize);
}
