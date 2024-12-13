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

  // text feild
  static const String feildRequired = "feildRequired";
  static const String pleaseEnterAValidEmailAddress =
      "pleaseEnterAValidEmailAddress";
  static const String welcomeBack = "welcomeBack";
  static const String logInntoYourAccount = "logInntoYourAccount";
  static const String password = "password";
  static const String confirmPassword = "confirmPassword";
  static const String email = "email";
  static const String rememberMe = "rememberMe";
  static const String login = "login";
  static const String needAnAccount = "needAnAccount";
  static const String signUp = "signUp";
  static const String forgetPassword = "forgetPassword";
  static const String passwordValidation = "passwordValidation";
  static const String createYourAccount = "createYourAccount";
  static const String letsGetYouStarted = "letsGetYouStarted";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String selectYourRoleToContinue = "selectYourRoleToContinue";
  static const String alreadyHaveAnAccount = "alreadyHaveAnAccount";
  static const String chooseYourRole = "chooseYourRole";
  static const String personalDriver = "personalDriver";
  static const String vehicleWorker = "vehicleWorker";
  static const String location = "location";
  static const String enterYourLocation = "enterYourLocation";
  static const String phoneNumber = "phoneNumber";
  static const String phoneNumberMustBe11Digits = "phoneNumberMustBe11Digits";
  //Repair Feature
  static const String requests = "requests";
  static const String whatHappening = "whatHappening";
  static const String sendCode = "sendCode";
  static const String resetPassword = "resetPassword";
  static const String resetPasswordSubtitle = "resetPasswordSubtitle";
}
