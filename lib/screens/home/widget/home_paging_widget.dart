import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_ui_model.dart';
import 'package:lydiaryanfluttersurvey/screens/common/background_widget.dart';

class HomePagingWidget extends StatelessWidget {
  final List<SurveyUiModel> surveys;

  const HomePagingWidget({super.key, required this.surveys});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return PageView(
        controller: pageController,
        children: surveys
            .map((SurveyUiModel survey) => _buildSurveyItem(context, survey))
            .toList());
  }

  Widget _buildSurveyItem(BuildContext context, SurveyUiModel survey) {
    return Stack(
      children: [
        BackgroundWidget(
          image: Image.network("${survey.coverImageUrl}l").image,
        ),
        SafeArea(
          child: Column(
            children: [
              _buildSurveyHeader(context, survey),
              const Spacer(),
              _buildSurveyFooter(context, survey),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSurveyHeader(BuildContext context, SurveyUiModel survey) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("EEEE, MMMM dd")
                    .format(survey.activeAt)
                    .toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 13),
              ),
              Text(
                _daysSince(context, survey.activeAt),
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
            //TODO add user avatar
          ),
        ],
      ),
    );
  }

  String _daysSince(BuildContext context, DateTime dateTime) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.parse(dateFormat.format(DateTime.now()));
    final DateTime date = DateTime.parse(dateFormat.format(dateTime));
    final difference = now.difference(date).inDays;
    if (difference == 0) {
      return AppLocalizations.of(context)!.today;
    } else if (difference == 1) {
      return AppLocalizations.of(context)!.yesterday;
    } else {
      return AppLocalizations.of(context)!.days_ago(difference);
    }
  }

  Widget _buildSurveyFooter(BuildContext context, SurveyUiModel survey) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO add page indicator?
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
                      )))
            ],
          )
        ],
      ),
    );
  }
}
