import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lydiaryanfluttersurvey/database/shared_preferences_utils.dart';
import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/app_input_widget.dart';
import 'package:lydiaryanfluttersurvey/utils/toast_message.dart';

import '../../base/base_view_model_state.dart';
import '../../di/injection.dart';
import '../../resources/dimensions.dart';
import '../../usecases/login_use_case.dart';
import '../widgets/circle_loading_indicator.dart';
import '../widgets/rounded_rectangle_button_widget.dart';
import 'login_keys.dart';
import 'login_view_model.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, BaseViewModelState>(
        (ref) {
  return LoginViewModel(
    getIt.get<LoginUseCase>(),
    getIt.get<SharedPreferencesUtils>(),
  );
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (ref.read(loginViewModelProvider.notifier).isLoggedIn()) {
      // TODO _navigateToHome()
      showToast('Logged In. Will navigate to Home Screen');
      return Container();
    }

    ref.listen<BaseViewModelState>(loginViewModelProvider, (_, state) {
      state.maybeWhen(
        success: () => showToast('Login Success'), // TODO _navigateToHome()
        apiError: (errorMessage) => showToast('Login Failed: $errorMessage'),
        invalidInputsError: () => showToast('Login Failed: Invalid Inputs'),
        orElse: () {},
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.images.bgLogin.path),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black.withOpacity(0.20),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingDefault),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.images.nimbleLogoWhite,
                        ),
                        const SizedBox(height: 109),
                        AppInputWidget(
                          key: LoginKey.liLoginEmail,
                          hintText: AppLocalizations.of(context)!.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          controller: _emailInputController,
                        ),
                        const SizedBox(height: Dimensions.paddingMedium),
                        AppInputWidget(
                          key: LoginKey.liLoginPassword,
                          hintText: AppLocalizations.of(context)!.password,
                          isPasswordType: true,
                          controller: _passwordInputController,
                        ),
                        const SizedBox(height: Dimensions.paddingMedium),
                        RoundedRectangleButtonWidget(
                          key: LoginKey.rrbLogin,
                          text: AppLocalizations.of(context)!.login,
                          onPressed: () {
                            ref.watch(loginViewModelProvider).maybeWhen(
                                loading: () {
                              return;
                            }, orElse: () {
                              ref.read(loginViewModelProvider.notifier).login(
                                    _emailInputController.text,
                                    _passwordInputController.text,
                                  );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          ref.watch(loginViewModelProvider).maybeWhen(
              loading: () => const CircleLoadingIndicator(),
              orElse: () => const SizedBox())
        ],
      ),
    );
  }
}
