import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lydiaryanfluttersurvey/base/base_view_model_state.dart';
import 'package:lydiaryanfluttersurvey/di/injection.dart';
import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/app_input_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/background_widget.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/circle_loading_indicator.dart';
import 'package:lydiaryanfluttersurvey/screens/widgets/rounded_rectangle_button_widget.dart';
import 'package:lydiaryanfluttersurvey/usecases/login_use_case.dart';
import 'package:lydiaryanfluttersurvey/utils/app_navigator.dart';
import 'package:lydiaryanfluttersurvey/utils/toast_message.dart';

import 'login_keys.dart';
import 'login_view_model.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, BaseViewModelState>(
        (ref) {
  return LoginViewModel(
    getIt.get<LoginUseCase>(),
  );
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _backgroundBlurAnimation;
  late Animation<double> _loginFieldsOpacityAnimation;
  late Animation<double> _logoFadeInAnimation;
  late Animation<double> _logoHeightAnimation;
  late Animation<double> _logoPositionAnimation;

  Animation<double> _buildAnimation({
    required double beginValue,
    required double endValue,
    required double startTime,
    required double endTime,
    Curve curve = Curves.linear,
  }) {
    return Tween<double>(
      begin: beginValue,
      end: endValue,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          startTime,
          endTime,
          curve: curve,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _logoFadeInAnimation = _buildAnimation(
      beginValue: 0,
      endValue: 1,
      startTime: 0.33,
      endTime: 0.495,
    );

    _logoHeightAnimation = _buildAnimation(
      beginValue: 48,
      endValue: 40,
      startTime: 0.66,
      endTime: 0.825,
    );

    _backgroundBlurAnimation = _buildAnimation(
      beginValue: 0,
      endValue: 25,
      startTime: 0.66,
      endTime: 0.825,
    );

    _loginFieldsOpacityAnimation = _buildAnimation(
      beginValue: 0,
      endValue: 1,
      startTime: 0.66,
      endTime: 0.825,
    );

    _logoPositionAnimation = _buildAnimation(
      beginValue: 1,
      endValue: 0.5,
      startTime: 0.66,
      endTime: 0.825,
      curve: Curves.fastOutSlowIn,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<BaseViewModelState>(loginViewModelProvider, (_, state) {
      state.maybeWhen(
        success: () {
          _navigateToHome(context);
        },
        apiError: (errorMessage) => showToast('Login Failed: $errorMessage'),
        invalidInputsError: () => showToast('Login Failed: Invalid Inputs'),
        orElse: () {},
      );
    });

    return AnimatedBuilder(
      animation: _animationController,
      builder: _buildAnimatedLoginWidgets,
    );
  }

  Widget _buildAnimatedLoginWidgets(BuildContext context, Widget? child) {
    return BackgroundWidget(
      image: Image.asset(Assets.images.bgLogin.path).image,
      shouldBlur: true,
      blurSigma: _backgroundBlurAnimation.value,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              _buildLogo(),
              _buildLoginFields(),
              ref.watch(loginViewModelProvider).maybeWhen(
                    loading: () => const CircleLoadingIndicator(),
                    orElse: () => const SizedBox(),
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return FractionallySizedBox(
      alignment: Alignment.center,
      heightFactor: _logoPositionAnimation.value,
      child: Container(
        height: _logoHeightAnimation.value,
        alignment: Alignment.center,
        child: Opacity(
          opacity: _logoFadeInAnimation.value,
          child: SvgPicture.asset(
            Assets.images.nimbleLogoWhite,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginFields() {
    return Center(
      child: Opacity(
        opacity: _loginFieldsOpacityAnimation.value,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimensions.paddingDefault),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                width: double.infinity,
                onPressed: () {
                  ref.watch(loginViewModelProvider).maybeWhen(loading: () {
                    return;
                  }, orElse: () {
                    ref.read(loginViewModelProvider.notifier).login(
                          _emailInputController.text,
                          _passwordInputController.text,
                        );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) =>
      context.push(RoutePath.home.path);
}
