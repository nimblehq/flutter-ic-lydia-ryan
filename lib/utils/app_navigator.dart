import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:lydiaryanfluttersurvey/screens/home/home_screen.dart';
import 'package:lydiaryanfluttersurvey/screens/login/login_screen.dart';
import 'package:lydiaryanfluttersurvey/screens/surveydetails/survey_detail_screen.dart';
import 'package:lydiaryanfluttersurvey/storage/shared_preferences_utils.dart';

enum RoutePath {
  login('/'),
  home('/home'),
  surveyDetails('surveyDetails');

  const RoutePath(this.path);

  final String path;

  String get screen {
    switch (this) {
      case RoutePath.home:
      case RoutePath.login:
        return path;
      default:
        return path.replaceRange(0, 1, '');
    }
  }

  String get screenWithArguments =>
      argument.isNotEmpty ? '$screen/:$argument' : screen;

  String get argument {
    switch (this) {
      case RoutePath.surveyDetails:
        return 'surveyId';
      default:
        return '';
    }
  }
}

@Singleton()
class AppNavigator {
  AppNavigator(this._sharePreferencesUtils);

  final SharedPreferencesUtils _sharePreferencesUtils;

  GoRouter router() => GoRouter(
        routes: <GoRoute>[
          GoRoute(
            path: RoutePath.login.screen,
            name: RoutePath.login.name,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: RoutePath.home.screen,
            name: RoutePath.home.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: RoutePath.surveyDetails.screenWithArguments,
                name: RoutePath.surveyDetails.name,
                builder: (context, state) => SurveyDetailScreen(
                  surveyId:
                      state.params[RoutePath.surveyDetails.argument] ?? '',
                ),
              ),
            ],
          ),
        ],
        redirect: (state) {
          final isLoggedIn = _sharePreferencesUtils.isLoggedIn;
          if (state.subloc == RoutePath.login.path && isLoggedIn) {
            return RoutePath.home.path;
          } else {
            return null;
          }
        },
        errorBuilder: (context, state) {
          return const LoginScreen();
        },
      );
}
