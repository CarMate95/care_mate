import 'dart:convert';

import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<UserModel> getUser() async {
    // CacheHelper.init();
    final token = ConstantsManager.token;
    final response = await http.get(
      Uri.parse('https://fb-m90x.onrender.com/user/myprofile'),
      headers: {
        'Content-Type': 'application/json',
        'token': '$token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success'] == true && responseData['data'] != null) {
        return UserModel.fromJson(responseData['data']['user']);
      } else {
        throw Exception('User data not found or invalid response');
      }
    } else {
      print("problem: ${response.body}");
      throw Exception('Failed to load user');
    }
  }
}
