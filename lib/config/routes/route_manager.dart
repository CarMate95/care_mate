import 'package:car_mate/features/my_car/models/note_model.dart';
import 'package:car_mate/features/my_car/pages/NoteDetailsScreen.dart';
import 'package:car_mate/features/my_car/pages/add_note_page.dart';
import 'package:car_mate/features/my_car/pages/licence_details_screen.dart';
import 'package:car_mate/features/my_car/pages/notes_list_screen.dart';
import 'package:car_mate/features/my_car/pages/upload_licence_screen.dart';
import 'package:car_mate/features/my_car/widgets/note_item.dart';
import 'package:car_mate/features/profile/screens/account_details_screen.dart';
import 'package:car_mate/features/profile/screens/settings_screen.dart';
import 'package:car_mate/features/repair/presentation/pages/create_post_screen.dart';
import 'package:car_mate/features/repair/presentation/pages/request_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_mate/features/splash/presentation/pages/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/new_password_screen.dart';
import '../../features/auth/presentation/pages/reset_password_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/auth/presentation/pages/verify_email_screen.dart';
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

      case PageName.verifyEmailScreen:
        return _getPageTransition(
          const VerifyEmailScreen(),
          settings: routeSettings,
        );

      case PageName.newPasswordScreen:
        return _getPageTransition(
          const NewPasswordScreen(),
          settings: routeSettings,
        );
        case PageName.addnotepage:
        return _getPageTransition(
           AddNotePage(),
          settings: routeSettings,
        );
        case PageName.licencedetailsscreen:
        return _getPageTransition(
           LicenceDetailsScreen(
              licenceImagePath: '',
              
           ),
          settings: routeSettings,
        );
        case PageName.notedetailsscreen:
        return _getPageTransition(
           NoteDetailsScreen(
             note: {},
           ),
          settings: routeSettings,
        );
        case PageName.noteslistscreen:
        return _getPageTransition(
           NotesListScreen(),
          settings: routeSettings,
        );
        case PageName.uploadlicencescreen:
        return _getPageTransition(
           UploadLicenceScreen(),
          settings: routeSettings,
        );
        case PageName.settingsScreen:
        return _getPageTransition(
           SettingsScreen(),
          settings: routeSettings,
        );
        case PageName.accountdetailsScreen:
        return _getPageTransition(
           AccountDetailsScreen(),
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
