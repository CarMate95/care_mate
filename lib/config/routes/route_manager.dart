import 'package:car_mate/features/repair/presentation/pages/create_post_screen.dart';
import 'package:car_mate/features/repair/presentation/pages/request_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/features/splash/presentation/pages/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/reset_password_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/layout/presentation/pages/layout_screen.dart';
import 'page_name.dart';

class RouteManager {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? ctx;

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PageName.splashScreen:
        return _getPageTransition(
          const SplashScreen(),
          settings: routeSettings,
        );

      case PageName.layoutScreen:
        return _getPageTransition(
          const LayoutScreen(),
          settings: routeSettings,
        );

      case PageName.loginScreen:
        return _getPageTransition(
          const LoginScreen(),
          settings: routeSettings,
        );

      case PageName.signUpScreen:
        return _getPageTransition(
          const SignUpScreen(),
          settings: routeSettings,
        );

      case PageName.resetPasswordScreen:
        return _getPageTransition(
          const ResetPasswordScreen(),
          settings: routeSettings,
        );
      case PageName.requestDetails:
        return _getPageTransition(
          const RequestDetailsScreen(),
          settings: routeSettings,
        );
      case PageName.createPostScreen:
        return _getPageTransition(
          const CreatePostScreen(),
          settings: routeSettings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }

  static PageTransition<dynamic> _getPageTransition(
    Widget screen, {
    RouteSettings? settings,
  }) {
    return PageTransition(
      child: screen,
      type: PageTransitionType.fade,
      curve: Curves.easeOut,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 500),
      settings: settings,
    );
  }
}
