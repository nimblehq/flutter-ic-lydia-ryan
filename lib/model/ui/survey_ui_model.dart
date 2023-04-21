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
}
