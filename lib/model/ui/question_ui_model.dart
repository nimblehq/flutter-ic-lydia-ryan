enum QuestionDisplayType {
  intro('intro'),
  star('star');

  const QuestionDisplayType(this.type);

  final String type;
}

class QuestionUiModel {
  final String id;
  final String title;
  final String text;
  final String displayOrder;
  final QuestionDisplayType displayType;
  final String coverImageUrl;

  QuestionUiModel({
    required this.id,
    required this.title,
    required this.text,
    required this.displayOrder,
    required this.displayType,
    required this.coverImageUrl,
  });

  String get largeCoverImageUrl => "${coverImageUrl}l";
}
