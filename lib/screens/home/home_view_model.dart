import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_view_model_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends StateNotifier<HomeViewModelState> {
  HomeViewModel() : super(const HomeViewModelState.init());

  final _surveysSubject = BehaviorSubject<List<SurveyUiModel>>();
  get surveysSubject => _surveysSubject.stream;

  void fetchSurveys() async {
    state = const HomeViewModelState.loading();

    // TODO: Implement fetchSurveys
    _surveysSubject.add(_mockSurveyUiModels);
    state = const HomeViewModelState.success();
  }
}

final List<SurveyUiModel> _mockSurveyUiModels = [
  SurveyUiModel(
    id: '1',
    title: 'Mock Survey 1',
    description: 'Mock Survey 1 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
  ),
  SurveyUiModel(
    id: '2',
    title: 'Mock Survey 2',
    description: 'Mock Survey 2 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_',
  ),
  SurveyUiModel(
    id: '3',
    title: 'Mock Survey 3',
    description: 'Mock Survey 3 Description',
    coverImageUrl:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
  ),
  SurveyUiModel(
    id: '4',
    title: 'Mock Survey 4',
    description: 'Mock Survey 4 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
  ),
  SurveyUiModel(
    id: '5',
    title: 'Mock Survey 5',
    description: 'Mock Survey 5 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_',
  )
];
