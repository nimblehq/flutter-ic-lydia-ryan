import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DateTimeExtension on DateTime {
  String daysSince(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.parse(dateFormat.format(DateTime.now()));
    final DateTime date = DateTime.parse(dateFormat.format(this));
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return AppLocalizations.of(context)!.today;
    }

    if (difference == 1) {
      return AppLocalizations.of(context)!.yesterday;
    }

    return AppLocalizations.of(context)!.days_ago(difference);
  }
}
