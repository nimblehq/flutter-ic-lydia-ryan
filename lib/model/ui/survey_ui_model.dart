import 'package:intl/intl.dart';
import 'package:lydiaryanfluttersurvey/model/response/survey_response.dart';

class SurveyUiModel {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final DateTime activeAt;

  SurveyUiModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.activeAt,
  });

  String formattedActiveAt() =>
      DateFormat("EEEE, MMMM dd").format(activeAt).toUpperCase();

  static SurveyUiModel fromSurveyResponse(SurveyResponse e) {
    return SurveyUiModel(
      id: e.id,
      title: e.title ?? "",
      description: e.description ?? "",
      coverImageUrl: e.coverImageUrl ?? "",
      activeAt: DateTime.parse(e.activeAt ?? "1970-01-01"),
    );
  }
}
