import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/background_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/rounded_rectangle_button_widget.dart';

class QuestionPagingWidget extends StatefulWidget {
  final List<QuestionUiModel> questions;

  const QuestionPagingWidget({super.key, required this.questions});

  @override
  State<StatefulWidget> createState() => _QuestionPagingWidgetState();
}

class _QuestionPagingWidgetState extends State<QuestionPagingWidget> {
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
          scrollBehavior: null,
          onPageChanged: _onPageChanged,
          children: widget.questions
              .map((QuestionUiModel question) => BackgroundWidget(
                    image: Image.network(question.largeCoverImageUrl).image,
                  ))
              .toList(),
        ),
        _buildQuestionContent(
            context, widget.questions[_currentIndex], pageController)
      ],
    );
  }

  Widget _buildQuestionContent(
    BuildContext context,
    QuestionUiModel question,
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
                _buildQuestionToolbar(context, question),
                const SizedBox(height: Dimensions.paddingLarge),
                _buildQuestionHeader(context, question),
                const Spacer(),
                _buildQuestionFooter(context, question, controller),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestionToolbar(BuildContext context, QuestionUiModel question) {
    return Row(
      children: [
        _isIntroQuestion(question)
            ? MaterialButton(
                onPressed: () => {context.pop()},
                minWidth: 30,
                height: 30,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(Assets.images.icBack),
              )
            : const SizedBox(),
        const Spacer(),
        !_isIntroQuestion(question)
            ? ElevatedButton(
                onPressed: () => {context.pop()},
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8.5),
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildQuestionHeader(BuildContext context, QuestionUiModel question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isIntroQuestion(question)) ...[
          Text(
            AppLocalizations.of(context)!.question_number(
              _currentIndex,
              widget.questions.length - 1,
            ),
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: Dimensions.paddingSmall),
          Text(
            question.text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ] else ...[
          Text(
            question.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              question.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuestionFooter(
    BuildContext context,
    QuestionUiModel question,
    PageController controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 20),
            child: _isIntroQuestion(question)
                ? _startSurveyButtonWidget(context)
                : _isLastQuestion(question)
                    ? _submitSurveyButtonWidget(context)
                    : _nextButtonWidget(context)),
      ],
    );
  }

  Widget _backButtonWidget(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {context.pop()},
      child: Icon(
        Icons.chevron_left,
        color: Theme.of(context).primaryColor,
        size: 30 * 0.75, // 75% of fab size
      ),
    );
  }

  Widget _nextButtonWidget(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => {},
      child: const Icon(
        Icons.chevron_right,
        color: Colors.black,
        size: 56 * 0.75, // 75% of fab size
      ),
    );
  }

  Widget _startSurveyButtonWidget(BuildContext context) {
    return SizedBox(
      child: RoundedRectangleButtonWidget(
        text: AppLocalizations.of(context)!.start_survey,
        onPressed: () {},
      ),
    );
  }

  Widget _submitSurveyButtonWidget(BuildContext context) {
    return RoundedRectangleButtonWidget(
      text: AppLocalizations.of(context)!.submit,
      onPressed: () {},
    );
  }

  bool _isIntroQuestion(QuestionUiModel question) =>
      question.displayType == QuestionDisplayType.intro;

  bool _isLastQuestion(QuestionUiModel question) =>
      widget.questions.indexOf(question) == widget.questions.length - 1;
}
