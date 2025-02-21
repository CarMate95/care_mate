import '../helpers/cache_helper.dart';

abstract class ConstantsManager {
  static const int splashDelay = 3; // 3 seconds

  // auth token
  static String? token = CacheHelper.getStringData('token');
  static bool? rememberMe = CacheHelper.getBoolData('rememberMe');
}
