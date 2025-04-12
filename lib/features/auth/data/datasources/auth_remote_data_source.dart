import 'package:car_mate/core/api/dio_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/api/end_points.dart';
import '../models/user_data.dart';

class AuthRemoteDataSource {
  final DioConsumer _dioConsumer;

  AuthRemoteDataSource(this._dioConsumer);

  // signup
  Future<void> signup({required UserData user}) async {
    await _dioConsumer.post(
      path: EndPoints.signup,
      body: user.toJson(),
    );
  }

  // login
  Future<String> login({
    required String email,
    required String password,
  }) async {
    var response = await _dioConsumer.post(
      path: EndPoints.login,
      body: {
        'email': email,
        'password': password,
      },
    );
    return response['data']['token'];
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // forget password
  Future<void> forgetPassword({required String email}) async {
    await _dioConsumer.post(
      path: EndPoints.forgetPassword,
      body: {
        'email': email,
      },
    );
  }

  // verify otp
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    await _dioConsumer.post(
      path: EndPoints.verifyOtp,
      body: {
        'email': email,
        'otp': otp,
      },
    );
  }

  // change password
  Future<void> changePassword({
    required String email,
    required String newPassword,
  }) async {
    await _dioConsumer.put(
      path: EndPoints.changePassword,
      body: {
        'email': email,
        'newPassword': newPassword,
      },
    );
  }
}
