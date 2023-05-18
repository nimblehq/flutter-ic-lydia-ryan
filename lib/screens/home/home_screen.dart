import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lydiaryanfluttersurvey/di/injection.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_state.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_view_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/widget/home_loading_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/home/widget/home_paging_widget.dart';
import 'package:lydiaryanfluttersurvey/usecases/get_surveys_use_case.dart';

final _homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    getIt.get<GetSurveysUseCase>(),
  );
});

final _surveysStreamProvider = StreamProvider.autoDispose<List<SurveyUiModel>>(
    (ref) => ref.watch(_homeViewModelProvider.notifier).surveys);

final _errorStreamProvider = StreamProvider.autoDispose<String>(
    (ref) => ref.watch(_homeViewModelProvider.notifier).error);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(_homeViewModelProvider.notifier).getSurveys();
  }

  @override
  Widget build(BuildContext context) {
    final surveys = ref.watch(_surveysStreamProvider).value ?? [];
    final error = ref.watch(_errorStreamProvider).value;

    return ref.watch<HomeState>(_homeViewModelProvider).when(
          init: () => const HomeLoadingWidget(),
          success: () => _buildHomeScreen(surveys, null),
          error: () => _buildHomeScreen(surveys, error),
        );
  }

  Widget _buildHomeScreen(
    List<SurveyUiModel> surveys,
    String? errorMessage,
  ) {
    if (errorMessage != null) {
      Fluttertoast.showToast(msg: errorMessage);
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(_homeViewModelProvider.notifier).getSurveys(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: HomePagingWidget(surveys: surveys),
          ),
        ),
      ),
    );
  }
}
