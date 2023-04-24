import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/home/widget/home_paging_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePagingWidget(surveys: _mockSurveyUiModels),
    );
  }
}

final List<SurveyUiModel> _mockSurveyUiModels = [
  SurveyUiModel(
    id: '1',
    title: 'Mock Survey 1',
    description: 'Mock Survey 1 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
    activeAt: DateTime.parse("2023-04-20T07:04:00.000Z"),
  ),
  SurveyUiModel(
    id: '2',
    title: 'Mock Survey 2',
    description: 'Mock Survey 2 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_',
    activeAt: DateTime.parse("2023-04-08T07:04:00.000Z"),
  ),
  SurveyUiModel(
    id: '3',
    title: 'Mock Survey 3',
    description: 'Mock Survey 3 Description',
    coverImageUrl:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
    activeAt: DateTime.parse("2023-02-03T07:04:00.000Z"),
  ),
  SurveyUiModel(
    id: '4',
    title: 'Mock Survey 4',
    description: 'Mock Survey 4 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_',
    activeAt: DateTime.parse("2017-10-08T07:04:00.000Z"),
  ),
  SurveyUiModel(
    id: '5',
    title: 'Mock Survey 5',
    description: 'Mock Survey 5 Description',
    coverImageUrl:
        'https://dhdbhh0jsld0o.cloudfront.net/m/287db81c5e4242412cc0_',
    activeAt: DateTime.parse("2015-10-08T07:04:00.000Z"),
  )
];
