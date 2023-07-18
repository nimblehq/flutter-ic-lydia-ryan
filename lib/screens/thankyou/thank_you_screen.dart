import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.images.icCompleteSurvey,
              height: Dimensions.thankYouIconSize,
              width: Dimensions.thankYouIconSize,
            ),
            Text(
              AppLocalizations.of(context)!.thank_you,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
