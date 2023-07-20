import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/model/ui/answer_ui_model.dart';
import 'package:lydiaryanfluttersurvey/model/ui/question_ui_model.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

const int _dropdownItemLength = 3;
const double _dropdownThreshold = 20.0;

class AnswerDropdownWidget extends StatefulWidget {
  final QuestionUiModel question;
  final Function(AnswerUiModel) onSelect;

  const AnswerDropdownWidget({
    Key? key,
    required this.question,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<AnswerDropdownWidget> createState() => _AnswerDropdownWidgetState();
}

class _AnswerDropdownWidgetState extends State<AnswerDropdownWidget> {
  int _focusedIndex = 0;

  Color? _getAnswerColor(int index) =>
      _focusedIndex == index ? Colors.white : Colors.white54;

  FontWeight _getAnswerFontWeight(int index) =>
      _focusedIndex == index ? FontWeight.bold : FontWeight.normal;

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
    widget.question.answers[index];
    widget.onSelect(widget.question.answers[index]);
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      height: Dimensions.answerDropdownHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.paddingLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.paddingSmall,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(widget.question.answers[index].text ?? "",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: _getAnswerColor(index),
                        fontWeight: _getAnswerFontWeight(index),
                      )),
            ),
          ),
          index < widget.question.answers.length - 1
              ? const Divider(
                  color: Colors.white,
                  thickness: Dimensions.dividerWidth,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (_dropdownItemLength * Dimensions.answerDropdownHeight) -
            _dropdownThreshold,
        child: ScrollSnapList(
          scrollDirection: Axis.vertical,
          onItemFocus: _onItemFocus,
          itemSize: Dimensions.answerDropdownHeight,
          itemBuilder: _buildListItem,
          itemCount: widget.question.answers.length,
        ),
      ),
    );
  }
}
