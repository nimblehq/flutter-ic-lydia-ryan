import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_view_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_view_model_state.dart';
import 'package:lydiaryanfluttersurvey/screens/home/widget/home_loading_widget.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeViewModelState>(
        (ref) => HomeViewModel());

final _surveysProvider = StreamProvider.autoDispose<List<SurveyUiModel>>(
    (ref) => ref.watch(homeViewModelProvider.notifier).surveysSubject);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).fetchSurveys();
  }

  @override
  Widget build(BuildContext context) {
    final surveys = ref.watch(_surveysProvider).value ?? [];

    return ref.watch(homeViewModelProvider).when(
          init: () => const HomeLoadingWidget(),
          loading: () => const HomeLoadingWidget(),
          success: () => _buildSurveyList(surveys),
          apiError: (errorMessage) => _buildSurveyList(surveys),
        );
  }

  Widget _buildSurveyList(
    List<SurveyUiModel> surveys,
  ) {
    return Scaffold(
      body: ListView.builder(
        itemCount: surveys.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              surveys[index].title,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
