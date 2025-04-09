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
  static const String update = "update";
  static const String noupdate = "noupdate";
  static const String updatedata = "updatedata";

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
  static const String post = "post";
  static const String offerhelp = "offerhelp";
  static const String cash = "cash";
  static const String note = "note";
  static const String by = "by";
  static const String too = "too";
  static const String workerDetails = "workerDetails";
  static const String sent = "sent";
  static const String requestData = "requestData";
  static const String ratingmessage = 'ratingmessage';
  static const String ratingMessage2 = 'Workers Service?';
  static const String bad = 'bad';
  static const String excellent = 'excellent';
  static const String worker = "worker";
  static const String winch = "winch";
  //otp
  static const String verifyYourEmailAddress = "verifyYourEmailAddress";
  static const String verifyWithTheCode = "VerifyWithTheCode";
  static const String resendAfter = "resendAfter";
  static const String minutes = "minutes";
  static const String seconds = "seconds";
  static const String resend = "resend";
  static const String verify = "verify";
  //mycar
  static const String uploadYourCarLicence = "uploadYourCarLicence";
  static const String setYourReminders = "setYourReminders";
  static const String fillYourReminderData = "fillYourReminderData";
  static const String title = "title";
  static const String startDate = "startDate";
  static const String endDate = "endDate";
  static const String save = "save";
  static const String searchForYourReminders = "searchForYourReminders";
  static const String camera = "camera";
  static const String gallery = "gallery";
  static const String done = "done";
  static const String noteDetails = "noteDetails";
  static const String start = "start";
  static const String end = "end";
  static const String noNotesFound = "noNotesFound";
  static const String noRemindersFound = "noRemindersFound";
  static const String deleteWarningNote = "deleteWarningNote";
  static const String deleteNote = "deleteNote";
  static const String cancel = "cancel";
  static const String phone = "phone";
  static const String settings = "settings";
  static const String accountDetails = "accountDetails";
  static const String shareApp = "shareApp";
  static const String notification = "notification";
  static const String appearance = "appearance";
  static const String language = "language";
  static const String deleteWarning = "deleteWarning";
  static const String deleteAccount = "deleteAccount";
  static const String logout = "logout";
  static const String areYouSure = "areYouSure";
  static const String delete = "delete";
  static const String logoutWarning = "logoutWarning";
  static const String mostafa = "Sasa💀";
  static const String mohamed = "Mohamed";
  static const String manooo = "Manoooo";
  static const String mohamedEzzat = "MohamedEzzat";
  static const String accountDeleted = "accountDeleted";
  static const String accountLogedOut = "accountLogedOut";
  static const String ok = "ok";
  static const String welcomeTo = "welcomeTo";
  static const String use = "use";
  static const String ai = "ai";
  static const String toDiagnose = "toDiagnose";
  static const String getStarted = "getStarted";
  static const String createNewPassword = "createNewPassword";
  static const String createNewPasswordText = "createNewPasswordText";
  static const String validationPass1 = "validationPass1";
  static const String validationPass2 = "validationPass2";
  static const String validationPass3 = "validationPass3";
  static const String addNote = "addNote";
  static const String edit = "edit";

  //Alerts screen
  static const String checkEngine = "checkEngine";
  static const String brakeWarning = "brakeWarning";
  static const String tirePressure = "tirePressure";
  static const String temperatureWarning = "temperatureWarning";
  static const String batteryWarning = "batteryWarning";
  static const String absWarning = "absWarning";
  static const String engineWarningLight = "engineWarningLight";
  static const String brakeWarningLight = "brakeWarningLight";
  static const String tirePressureWarningLight = "tirePressureWarningLight";
  static const String temperatureWarningLight = "temperatureWarningLight";
  static const String batteryWarningLight = "batteryWarningLight";
  static const String absWarningLight = "absWarningLight";
  static const String checkEngineAlertMessage = "checkEngineAlertMessage";
  static const String brakeWarningAlertMessage = "brakeWarningAlertMessage";
  static const String tirePressureAlertMessage = "tirePressureAlertMessage";
  static const String temperatureWarningAlertMessage =
      "temperatureWarningAlertMessage";
  static const String batteryWarningAlertMessage = "batteryWarningAlertMessage";
  static const String absWarningAlertMessage = "absWarningAlertMessage";
  static const String alerts = "alerts";
  static const String signs = "signs";

  //Notifications screen

  static const String appUpdateAlert = "appUpdateAlert";
  static const String hAgo = "hAgo";
  static const String newFeatures = "newFeatures";
  static const String today = "today";
  static const String yesterday = "yesterday";
  static const String lastDays = "lastDays";

  //Home screen
  static const String rawanAyman = "rawanAyman";
  static const String setReminder = "setReminder";
  static const String viewWorkers = "viewWorkers";
  static const String signAndAlerts = "signAndAlerts";
  static const String mechanicCanHelp = "mechanicCanHelp";
  static const String shareYourCarProblem = "shareYourCarProblem";
  static const String donForgetTo = "donForgetTo";
  static const String changeFuel = "changeFuel";
  static const String startTime = "startTime";
  static const String endTime = "endTime";
  static const String loginSuccessfully = "loginSuccessfully";
  static const String signUpSuccessfully = "signUpSuccessfully";
  static const String checkYourEmail = "checkYourEmail";
  static const String hello = "hello";
  static const String howCanIAssistYouRightNow = "howCanIAssistYouRightNow";
  static const String useAIToAnalyzeComplexCarProblems =
      "useAIToAnalyzeComplexCarProblems";
  static const String estimateYourCarsValue = "estimateYourCarsValue";
  static const String aIDrivenCarHealthCheck = "aIDrivenCarHealthCheck";
  static const String noteAIin = "noteAIin";
  static const String beta = "beta";
  static const String answersMayNotBeFully = "answersMayNotBeFully";
  static const String accurate = "accurate";
  static const String aiTyping = "aiTyping";
  //Pick an image
  static const String pickAnImage = "pickAnImage";
  static const String askAI = "askAI";
  static const String offers = 'offers';
}
