import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:lydiaryanfluttersurvey/model/response/question_response.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/survey_detail_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_dropdown_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_intro_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_multi_choice_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_nps_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_rating_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_smiley_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_text_area_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/widget/answer_text_field_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/rounded_rectangle_button_widget.dart';
import 'package:lydiaryanfluttersurvey/utils/app_navigator.dart';

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

    return SafeArea(
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
          _buildAnswerIntroWidget(widget.surveyDetailUiModel.title, question)
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
      case DisplayType.nps:
        return _buildAnswerNpsRatingWidget(question);
      case DisplayType.star:
        return _buildAnswerEmojiRatingWidget(question, '⭐️');
      case DisplayType.thumbs:
        return _buildAnswerEmojiRatingWidget(question, '👍🏻');
      case DisplayType.smiley:
        return _buildAnswerSmileyWidget(question);
      case DisplayType.textarea:
        return _buildAnswerTextAreaWidget(question);
      case DisplayType.textfield:
        return _buildAnswerTextFieldWidget(question);
      case DisplayType.choice:
        return _buildAnswerMultiChoiceWidget(question);
      case DisplayType.dropdown:
        return _buildAnswerDropdownWidget(question);
      default:
        return const SizedBox();
    }
  }

  Widget _buildAnswerIntroWidget(String title, QuestionUiModel question) {
    return AnswerIntroWidget(
      title: title,
      description: question.text,
    );
  }

  Widget _buildAnswerNpsRatingWidget(QuestionUiModel question) {
    return AnswerNpsWidget(
      count: question.answers.length,
      onRatingChange: (int rating) {
        // TODO: Save answer here
      },
    );
  }

  Widget _buildAnswerEmojiRatingWidget(QuestionUiModel question, String emoji) {
    return AnswerEmojiRatingWidget(
      emoji: emoji,
      count: question.answers.length,
      onRatingChange: (int rating) {
        // TODO: Save answer here
      },
    );
  }

  Widget _buildAnswerSmileyWidget(QuestionUiModel question) {
    return AnswerSmileyWidget(
      onSelect: (int score) {
        // TODO: Save answer here
      },
    );
  }

  Widget _buildAnswerTextFieldWidget(QuestionUiModel question) {
    return AnswerTextFieldWidget(
      question: question,
      onAnswer: (List<String> answers) {
        // TODO: Save answer here
      },
    );
  }

  Widget _buildAnswerTextAreaWidget(QuestionUiModel question) {
    return AnswerTextAreaWidget(
      question: question,
      onAnswer: (String answer) {
        // TODO: Save answer here
      },
    );
  }

  Widget _buildAnswerMultiChoiceWidget(QuestionUiModel question) {
    return AnswerMultiChoiceWidget(
        question: question,
        onCheck: (List<String> answerIds) {
          // TODO: Save answer here
        });
  }

  Widget _buildAnswerDropdownWidget(QuestionUiModel question) {
    return AnswerDropdownWidget(
        question: question,
        onSelect: (String answer) {
          // TODO: Save answer here
        });
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
      onPressed: () {
        // TODO: submit survey here
        context.push(RoutePath.thankYou.path);
      },
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
