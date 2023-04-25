import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/question_paging_widget.dart';

class SurveyDetailsScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailsScreen({required this.surveyId, super.key});

  @override
  ConsumerState<SurveyDetailsScreen> createState() =>
      _SurveyDetailsScreenState();
}

class _SurveyDetailsScreenState extends ConsumerState<SurveyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionPagingWidget(questions: _mockQuestionUiModels),
    );
  }
}

final List<QuestionUiModel> _mockQuestionUiModels = [
  QuestionUiModel(
    id: '1',
    title: 'Mock Survey Intro',
    text: 'Mock Survey Intro Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
    displayType: QuestionDisplayType.intro,
    displayOrder: '0',
  ),
  QuestionUiModel(
    id: '2',
    title: 'Mock Survey 1',
    text: 'Mock Survey 1 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
    displayType: QuestionDisplayType.star,
    displayOrder: '1',
  ),
  QuestionUiModel(
    id: '3',
    title: 'Mock Survey 2',
    text: 'Mock Survey 2 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
    displayType: QuestionDisplayType.star,
    displayOrder: '2',
  ),
  QuestionUiModel(
    id: '4',
    title: 'Mock Survey 3',
    text: 'Mock Survey 3 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
    displayType: QuestionDisplayType.star,
    displayOrder: '3',
  ),
];
