import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lydiaryanfluttersurvey/di/injection.dart';
import 'package:lydiaryanfluttersurvey/model/response/question_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_detail_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/survey_detail_view_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/question_paging_widget.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_survey_detail_use_case.dart';

import 'survey_detail_state.dart';

final _surveyDetailViewModelProvider =
    StateNotifierProvider.autoDispose<SurveyDetailViewModel, SurveyDetailState>(
  (ref) => SurveyDetailViewModel(
    getIt.get<GetSurveyDetailUseCase>(),
  ),
);

final _surveyDetailStreamProvider =
    StreamProvider.autoDispose<SurveyDetailUiModel>(
  (ref) => ref.watch(_surveyDetailViewModelProvider.notifier).surveyDetail,
);

class SurveyDetailsScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailsScreen({required this.surveyId, super.key});

  @override
  ConsumerState<SurveyDetailsScreen> createState() =>
      _SurveyDetailsScreenState();
}

class _SurveyDetailsScreenState extends ConsumerState<SurveyDetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref
        .read(_surveyDetailViewModelProvider.notifier)
        .getSurveyDetail(widget.surveyId);
  }

  @override
  Widget build(BuildContext context) {
    final surveyDetail = ref.watch(_surveyDetailStreamProvider).value;
    return ref.watch<SurveyDetailState>(_surveyDetailViewModelProvider).when(
          init: () => const Center(child: CircularProgressIndicator()),
          success: () => _buildSurveyDetailsScreen(surveyDetail, null),
          error: (exception) =>
              _buildSurveyDetailsScreen(surveyDetail, exception.toString()),
        );
  }

  Widget _buildSurveyDetailsScreen(
    SurveyDetailUiModel? surveyDetail,
    String? errorMessage,
  ) {
    if (errorMessage != null) {
      Fluttertoast.showToast(msg: errorMessage);
    }

    return surveyDetail != null
        ? Scaffold(
            body: QuestionPagingWidget(surveyDetailUiModel: surveyDetail),
          )
        : const SizedBox.shrink();
  }
}

final SurveyDetailUiModel _mockSurveyDetailUiModel = SurveyDetailUiModel(
  id: "id",
  title: "title",
  description: "description",
  coverImageUrl: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_",
  questions: _mockQuestionUiModels,
);

final List<QuestionUiModel> _mockQuestionUiModels = [
  QuestionUiModel(
    id: '1',
    text: 'Mock Survey intro question 1',
    displayType: DisplayType.intro,
    answers: [],
  ),
  QuestionUiModel(
    id: '2',
    text: 'Mock Survey intro question 2',
    displayType: DisplayType.star,
    answers: [],
  ),
  QuestionUiModel(
    id: '1',
    text: 'Mock Survey intro question 3',
    displayType: DisplayType.textarea,
    answers: [],
  ),
  QuestionUiModel(
    id: '1',
    text: 'Mock Survey intro question 4',
    displayType: DisplayType.choice,
    answers: [],
  ),
  QuestionUiModel(
    id: '1',
    text: 'Mock Survey intro question 5',
    displayType: DisplayType.smiley,
    answers: [],
  ),
];
