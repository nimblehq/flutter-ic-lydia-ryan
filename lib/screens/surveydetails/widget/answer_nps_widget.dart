import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

const int _npsMaxSize = 10;

class AnswerNpsWidget extends StatefulWidget {
  final int count;
  final Function(int) onRated;

  const AnswerNpsWidget({
    Key? key,
    required this.count,
    required this.onRated,
  }) : super(key: key);

  @override
  State<AnswerNpsWidget> createState() => _AnswerNpsWidgetState();
}

class _AnswerNpsWidgetState extends State<AnswerNpsWidget> {
  int? selectedIndex;

  void _setNpsValue(int index) {
    setState(() => selectedIndex = index);
    widget.onRated(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildNpsPicker(),
        const SizedBox(
          height: 15,
        ),
        _buildNpsLabels(),
      ],
    );
  }

  Widget _buildNpsPicker() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: Dimensions.answerNpsDividerWidth,
        ),
        borderRadius:
            BorderRadius.circular(Dimensions.radiusRoundedRectangleButton),
      ),
      padding: const EdgeInsets.only(
        left: Dimensions.paddingSmall,
        right: Dimensions.paddingSmall,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _npsWidgets,
        ),
      ),
    );
  }

  List<Widget> get _npsWidgets {
    List<Widget> widgets = [];
    for (int index = 0; index < min(widget.count, _npsMaxSize); index++) {
      if (index != 0) {
        widgets.add(
          const VerticalDivider(
            thickness: Dimensions.answerNpsDividerWidth,
            color: Colors.white,
          ),
        );
      }
      final isSelected = index <= (selectedIndex ?? -1);
      widgets.add(
        GestureDetector(
          onTapDown: (details) => _setNpsValue(index),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              (index + 1).toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.white54,
                  ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _buildNpsLabels() {
    final isLikely =
        (selectedIndex ?? -1) >= (min(widget.count, _npsMaxSize) / 2);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.nps_not_likely,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isLikely ? FontWeight.normal : FontWeight.bold,
                color: isLikely ? Colors.white54 : Colors.white,
              ),
        ),
        Text(
          AppLocalizations.of(context)!.nps_extremely_likely,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isLikely ? FontWeight.bold : FontWeight.normal,
                color: isLikely ? Colors.white : Colors.white54,
              ),
        ),
      ],
    );
  }
}
