import 'dart:convert';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/notifications/data/models/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  final String baseUrl = 'https://fb-m90x.onrender.com';

  Future<List<NotificationModel>> getNotifications() async {
    final response = await http.get(
      Uri.parse('$baseUrl/notification'),
      headers: {
        'Content-Type': 'application/json',
        'token': '${ConstantsManager.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['notifications'];
      return data.map((notifJson) => NotificationModel.fromJson(notifJson)).toList();
    } else {
      throw Exception('Failed to fetch notifications: ${response.body}');
    }
  }
}
