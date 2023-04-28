class AnswerUiModel {
  final String id;
  final int score;
  final String? inputMaskPlaceholder;

  AnswerUiModel({
    required this.id,
    required this.score,
    this.inputMaskPlaceholder,
  });
}
