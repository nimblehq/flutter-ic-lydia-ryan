import 'package:lydiaryanfluttersurvey/model/response/surveys_meta_response.dart';

class SurveyMetaModel {
  final int page;
  final int pages;
  final int pageSize;
  final int records;

  SurveyMetaModel(
    this.page,
    this.pages,
    this.pageSize,
    this.records,
  );

  int get fetchedRecords => page * pageSize;

  static SurveyMetaModel fromResponse(SurveysMetaResponse? response) {
    return SurveyMetaModel(
      response?.page ?? 0,
      response?.pages ?? 0,
      response?.pageSize ?? 0,
      response?.records ?? 0,
    );
  }
}
