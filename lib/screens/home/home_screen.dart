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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _currentPageIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    ref.read(_homeViewModelProvider.notifier).getSurveys();
    _setupListener();
  }

  @override
  void dispose() {
    _currentPageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surveys = ref.watch(_surveysStreamProvider).value ?? [];

    return ref.watch<HomeState>(_homeViewModelProvider).when(
          init: () => const HomeLoadingWidget(),
          success: () => _buildHomeScreen(surveys, null),
          error: (exception) => _buildHomeScreen(surveys, exception.toString()),
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
            child: HomePagingWidget(
                surveys: surveys,
                onPageChanged: (index) {
                  _currentPageIndex.value = index;
                }),
          ),
        ),
      ),
    );
  }

  void _setupListener() {
    _currentPageIndex.addListener(() {
      final currentPageIndex = _currentPageIndex.value;
      final surveys = ref.read(_surveysStreamProvider).value ?? [];
      if (currentPageIndex == surveys.length - 2) {
        ref.read(_homeViewModelProvider.notifier).getSurveys();
      }
    });
  }
}
