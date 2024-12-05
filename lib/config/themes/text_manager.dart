/// This class contains all keys, and then use these keys in translation files.
abstract class TextManager {
  /// Response messages
  static const String success = "success";
  static const String noContent = "noContent";
  static const String badRequest = "badRequest";
  static const String unauthorized = "unauthorized";
  static const String forbidden = "forbidden";
  static const String notFound = "notFound";
  static const String conflict = "conflict";
  static const String methodNotAllowed = "methodNotAllowed";
  static const String internalServerError = "internalServerError";
  static const String connectTimeout = "connectTimeout";
  static const String cancelMessage = "cancelMessage";
  static const String receiveTimeout = "receiveTimeout";
  static const String sendTimeout = "sendTimeout";
  static const String cashError = "cashError";
  static const String noInternetConnection = "noInternetConnection";
  static const String unknown = "unknown";

  /// Language
  // (these values do not need to be translated)
  // as they are used only inside the code, and user does not see them
  static const String english = "English";
  static const String arabic = "العربية";
  static const String french = "Français";
  static const String fr = 'fr';
  static const String ar = 'ar';
  static const String en = 'en';

  static const String phoneAlreadyExists = 'phoneAlreadyExists';
  static const String loading = 'loading';
  static const String noInternet = "noInternet";
  
  // CarMate
  static const String home = "home";
  static const String repair = "repair";
  static const String myCar = "myCar";
  static const String aiChat = "aiChat";

}
