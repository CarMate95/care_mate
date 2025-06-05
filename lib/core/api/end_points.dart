abstract class EndPoints {
  static const String baseUrl = "https://fb-m90x.onrender.com";

  static const String signup = "/auth/signup";
  static const String login = "/auth/login";
  static const String profile = "/user/myprofile";
  static const String update = "/user/updateprofile";
  static const String delete = "/user/deleteprofile";
  static const String forgetPassword = "/auth/forget-password";
  static const String verifyOtp = "/auth/verify";
  static const String changePassword = "/auth/change-password";
  static const String createNote = "/user/addreminder";
  static const String updateNote = "/user/updatereminder/1";
  static const String getNote = "/user/getreminder";
  static const String deleteNote = "/user/deletereminder/2";
  static const String getCarProblem =
      "https://carmate.smartsminds.com/api/car_problem/diagnose/";
  static const String getCarPrice =
      "https://carmate.smartsminds.com/api/car_price/predict/";
}
