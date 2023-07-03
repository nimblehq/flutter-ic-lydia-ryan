import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/api/repository/survey_repository.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_detail_response.dart';

import 'base/base_use_case.dart';

@Injectable()
class GetSurveyDetailUseCase extends UseCase<SurveyDetailResponse, String> {
  final SurveyRepository _surveyRepository;

  GetSurveyDetailUseCase(this._surveyRepository);

  @override
  Future<Result<SurveyDetailResponse>> call(String params) {
    return _surveyRepository
        .getSurveyDetail(params)
        // ignore: unnecessary_cast
        .then((value) => Success(value) as Result<SurveyDetailResponse>)
        .onError<Exception>(
            (error, stackTrace) => Failed(UseCaseException(error)));
  }
}
