import 'dart:convert';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/get_specific_post_model.dart';
import 'package:http/http.dart' as http;

class GetSpecificPostRepository {
  final String baseUrl = 'https://fb-m90x.onrender.com';

  Future<GetSpecificPostModel> getPostById(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/post/getPost/$id'), headers: {
      'Content-Type': 'application/json',
      'token': '${ConstantsManager.token}',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['post'];
      return GetSpecificPostModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}
