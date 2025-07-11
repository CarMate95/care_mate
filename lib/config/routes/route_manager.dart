import 'package:car_mate/core/utils/widgets/custom_bottom_navigation.dart';
import 'package:car_mate/features/alerts/presentation/pages/alerts_signs_screen.dart';
import 'package:car_mate/features/chat/presentation/pages/car_price_screen.dart';
import 'package:car_mate/features/home/presentation/pages/home_screen.dart';
import 'package:car_mate/features/my_car/pages/NoteDetailsScreen.dart';
import 'package:car_mate/features/my_car/pages/add_note_page.dart';
import 'package:car_mate/features/my_car/pages/licence_details_screen.dart';
import 'package:car_mate/features/my_car/pages/notes_list_screen.dart';
import 'package:car_mate/features/my_car/pages/upload_licence_screen.dart';
import 'package:car_mate/features/notifications/presentation/pages/notification_screen.dart';
import 'package:car_mate/features/profile/screens/account_details_screen.dart';
import 'package:car_mate/features/profile/screens/settings_screen.dart';
import 'package:car_mate/features/repair/data/models/request_model.dart';
import 'package:car_mate/features/repair/data/repo/request_repo_implementation.dart';
import 'package:car_mate/features/repair/presentation/manager/cubit/get_offers_cubit.dart';
import 'package:car_mate/features/repair/presentation/views/create_post_screen.dart';
import 'package:car_mate/features/repair/presentation/views/edite_worker_details_screen.dart';
import 'package:car_mate/features/repair/presentation/views/offers_view.dart';
import 'package:car_mate/features/repair/presentation/views/session_screen.dart';
import 'package:car_mate/features/repair/presentation/views/winch_worker_screen.dart';
import 'package:car_mate/features/repair/presentation/views/worker_details_screen.dart';
import 'package:car_mate/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/new_password_screen.dart';
import '../../features/auth/presentation/pages/reset_password_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/auth/presentation/pages/verify_otp_screen.dart';
import '../../features/chat/presentation/pages/car_problem_screen.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/layout/presentation/pages/layout_screen.dart';
import '../../features/splash/presentation/pages/on_boarding_screen.dart';
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
      case PageName.createPostScreen:
        return _getPageTransition(
          const CreatePostScreen(),
          settings: routeSettings,
        );

      case PageName.notificationScreen:
        return _getPageTransition(
          const NotificationScreen(),
          settings: routeSettings,
        );

      case PageName.alertsScreen:
        return _getPageTransition(
          const AlertsSignsScreen(),
          settings: routeSettings,
        );

      case PageName.verifyOtpScreen:
        return _getPageTransition(
          const VerifyOtpScreen(),
          settings: routeSettings,
        );

      case PageName.newPasswordScreen:
        return _getPageTransition(
          const NewPasswordScreen(),
          settings: routeSettings,
        );
      case PageName.addnotepage:
        return _getPageTransition(
          const AddNotePage(),
          settings: routeSettings,
        );
      case PageName.licencedetailsscreen:
        return _getPageTransition(
          const LicenceDetailsScreen(
            licenceImagePath: '',
          ),
          settings: routeSettings,
        );
      case PageName.notedetailsscreen:
        return _getPageTransition(
          const NoteDetailsScreen(
            note: {},
          ),
          settings: routeSettings,
        );
      case PageName.noteslistscreen:
        return _getPageTransition(
          const NotesListScreen(),
          settings: routeSettings,
        );
      case PageName.uploadlicencescreen:
        return _getPageTransition(
          const UploadLicenceScreen(),
          settings: routeSettings,
        );
      case PageName.settingsScreen:
        return _getPageTransition(
          const SettingsScreen(),
          settings: routeSettings,
        );
      case PageName.accountdetailsScreen:
        return _getPageTransition(
          const AccountDetailsScreen(),
          settings: routeSettings,
        );
      case PageName.editeWorkerDetailsScreen:
        return _getPageTransition(
          const EditeWorkerDetailsScreen(),
          settings: routeSettings,
        );

      case PageName.winchAndWorkerScreen:
        return _getPageTransition(
          BlocProvider<GetOffersCubit>(
            create: (context) =>
                GetOffersCubit(OfferRepositoryImplementation()),
            child: const WorkerAndWinchScreen(),
          ),
          settings: routeSettings,
        );
      case PageName.workerDetailsScreen:
        final OfferModel workerModel = routeSettings.arguments as OfferModel;

        return _getPageTransition(
          WorkerDetailsScreen(
            offerModel: workerModel,
          ),
          settings: routeSettings,
        );

      case PageName.homeScreen:
        return _getPageTransition(
          const HomeScreen(),
          settings: routeSettings,
        );
      case PageName.customBottomNavigation:
        return _getPageTransition(
          const CustomBottomNavigation(),
          settings: routeSettings,
        );

      case PageName.onBoardingScreen:
        return _getPageTransition(
          const OnBoardingScreen(),
          settings: routeSettings,
        );

      case PageName.chatScreen:
        return _getPageTransition(
          const ChatScreen(),
          settings: routeSettings,
        );

      case PageName.getOfferScreen:
        return _getPageTransition(
          const OffersView(),
          settings: routeSettings,
        );

      case PageName.carPriceScreen:
        return _getPageTransition(
          const CarPriceScreen(),
          settings: routeSettings,
        );

      case PageName.carProblemScreen:
        return _getPageTransition(
          const CarProblemScreen(),
          settings: routeSettings,
        );

      case PageName.sessionScreen:
        return _getPageTransition(
          BlocProvider<GetOffersCubit>(
            create: (context) => GetOffersCubit(OfferRepositoryImplementation())
              ..fetchSessions(),
            child: const SessionScreen(),
          ),
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
