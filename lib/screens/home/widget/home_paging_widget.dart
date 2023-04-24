import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/extension/date_time_extension.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/background_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePagingWidget extends StatefulWidget {
  final List<SurveyUiModel> surveys;

  const HomePagingWidget({super.key, required this.surveys});

  @override
  State<StatefulWidget> createState() => _HomePagingWidgetState();
}

class _HomePagingWidgetState extends State<HomePagingWidget> {
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Stack(
      children: [
        PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          children: widget.surveys
              .map((SurveyUiModel survey) => BackgroundWidget(
                    image: Image.network("${survey.coverImageUrl}l").image,
                  ))
              .toList(),
        ),
        _buildSurveyItem(context, widget.surveys[_currentIndex], pageController)
      ],
    );
  }

  Widget _buildSurveyItem(
    BuildContext context,
    SurveyUiModel survey,
    PageController controller,
  ) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSurveyHeader(context, survey),
                const Spacer(),
                _buildSurveyFooter(context, survey, controller),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSurveyHeader(BuildContext context, SurveyUiModel survey) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              survey.formattedActiveAt(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 13),
            ),
            Text(
              survey.activeAt.daysSince(context),
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
          //TODO add user avatar
        ),
      ],
    );
  }

  Widget _buildSurveyFooter(
    BuildContext context,
    SurveyUiModel survey,
    PageController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SmoothPageIndicator(
            controller: controller,
            count: widget.surveys.length,
            effect: const ScrollingDotsEffect(
              dotColor: Colors.white24,
              activeDotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ),
        Text(survey.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium),
        Row(
          children: [
            Expanded(
                child: Text(survey.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium)),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () => {},
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 56 * 0.75, // 75% of fab size
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
