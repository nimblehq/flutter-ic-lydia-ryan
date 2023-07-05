import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:lydiaryanfluttersurvey/model/response/question_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_detail_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_rating_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/background_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/rounded_rectangle_button_widget.dart';

class QuestionPagingWidget extends StatefulWidget {
  final SurveyDetailUiModel surveyDetailUiModel;

  const QuestionPagingWidget({super.key, required this.surveyDetailUiModel});

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
    if (widget.surveyDetailUiModel.questions.isEmpty) {
      return const SizedBox.expand();
    }
    final PageController pageController = PageController();

    return Stack(
      children: [
        BackgroundWidget(
          image: Image.network(widget.surveyDetailUiModel.largeCoverImageUrl)
              .image,
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionToolbar(
                  context,
                  widget.surveyDetailUiModel.questions[_currentIndex],
                ),
                _buildPagedQuestions(context, pageController),
                _buildQuestionFooter(
                  context,
                  widget.surveyDetailUiModel.questions[_currentIndex],
                  pageController,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagedQuestions(
    BuildContext context,
    PageController pageController,
  ) {
    return Expanded(
      child: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.surveyDetailUiModel.questions
            .map((QuestionUiModel question) =>
                _buildQuestionHeaderAndAnswerContent(context, question))
            .toList(),
      ),
    );
  }

  Widget _buildQuestionToolbar(BuildContext context, QuestionUiModel question) {
    final isIntroQuestion = _isIntroQuestion(question);
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingMedium),
      child: SizedBox(
        height: 44.0,
        child: Row(
          children: [
            isIntroQuestion
                ? MaterialButton(
                    onPressed: () => context.pop(),
                    minWidth: 30,
                    height: 30,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    child: SvgPicture.asset(Assets.images.icBack),
                  )
                : const SizedBox(),
            const Spacer(),
            if (!isIntroQuestion)
              MaterialButton(
                onPressed: () => context.pop(),
                minWidth: 28,
                height: 28,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: Colors.white.withOpacity(0.2),
                textColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionHeaderAndAnswerContent(
      BuildContext context, QuestionUiModel question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isIntroQuestion(question)) ...[
          Text(
            AppLocalizations.of(context)!.question_number(
              _currentIndex,
              widget.surveyDetailUiModel.questions.length - 1,
            ),
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
          ),
          const SizedBox(height: Dimensions.paddingSmall),
          Text(
            question.text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          _buildAnswerContent(
              context, widget.surveyDetailUiModel.questions[_currentIndex]),
        ] else ...[
          Text(
            widget.surveyDetailUiModel.title,
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

  Widget _buildAnswerContent(BuildContext context, QuestionUiModel question) {
    return Expanded(
      child: _buildAnswerWidget(question),
    );
  }

  Widget _buildAnswerWidget(QuestionUiModel question) {
    switch (question.displayType) {
      case DisplayType.star:
        return _buildAnswerEmojiRatingWidget(question, '⭐️');
      case DisplayType.thumbs:
        return _buildAnswerEmojiRatingWidget(question, '👍🏻');
      default:
        return const SizedBox();
    }
  }

  Widget _buildAnswerEmojiRatingWidget(QuestionUiModel question, String emoji) {
    return AnswerEmojiRatingWidget(
      emoji: emoji,
      count: question.answers.length,
      onRated: (int rating) {
        // TODO: Save answer here
      },
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
                ? _startSurveyButtonWidget(context, controller)
                : _isLastQuestion(question)
                    ? _submitSurveyButtonWidget(context)
                    : _nextButtonWidget(context, controller)),
      ],
    );
  }

  Widget _nextButtonWidget(BuildContext context, PageController controller) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => _nextPage(controller),
      child: const Icon(
        Icons.chevron_right,
        color: Colors.black,
        size: 56 * 0.75, // 75% of fab size
      ),
    );
  }

  Widget _startSurveyButtonWidget(
      BuildContext context, PageController controller) {
    return SizedBox(
      child: RoundedRectangleButtonWidget(
        text: AppLocalizations.of(context)!.start_survey,
        onPressed: () => _nextPage(controller),
      ),
    );
  }

  Widget _submitSurveyButtonWidget(BuildContext context) {
    return RoundedRectangleButtonWidget(
      text: AppLocalizations.of(context)!.submit,
      onPressed: () {},
    );
  }

  void _nextPage(PageController controller) {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  bool _isIntroQuestion(QuestionUiModel question) =>
      question.displayType == DisplayType.intro;

  bool _isLastQuestion(QuestionUiModel question) =>
      widget.surveyDetailUiModel.questions.indexOf(question) ==
      widget.surveyDetailUiModel.questions.length - 1;
}
