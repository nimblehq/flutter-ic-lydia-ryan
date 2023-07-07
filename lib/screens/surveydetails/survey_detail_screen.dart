import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lydiaryanfluttersurvey/di/injection.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_detail_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/survey_detail_view_model.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/question_paging_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/background_widget.dart';
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

class SurveyDetailScreen extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailScreen({required this.surveyId, super.key});

  @override
  ConsumerState<SurveyDetailScreen> createState() => _SurveyDetailScreenState();
}

class _SurveyDetailScreenState extends ConsumerState<SurveyDetailScreen> {
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
          success: () => _buildSurveyDetailScreen(surveyDetail, null),
          error: (exception) =>
              _buildSurveyDetailScreen(surveyDetail, exception.toString()),
        );
  }

  Widget _buildSurveyDetailScreen(
    SurveyDetailUiModel? surveyDetail,
    String? errorMessage,
  ) {
    if (errorMessage != null) {
      Fluttertoast.showToast(msg: errorMessage);
    }

    if (surveyDetail == null) {
      return const SizedBox.shrink();
    }

    return BackgroundWidget(
      image: Image.network(surveyDetail.largeCoverImageUrl).image,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: QuestionPagingWidget(surveyDetailUiModel: surveyDetail),
      ),
    );
  }
}
