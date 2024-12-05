import 'package:flutter/material.dart';
import 'package:car_mate/features/splash/presentation/pages/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
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
