import 'dart:convert';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/add_post_model.dart';
import 'package:http/http.dart' as http;

class AddPostRepository {
  final String apiUrl = 'https://fb-m90x.onrender.com';

  Future<Map<String, dynamic>> createPost(AddPostModel post) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/post/createPost'),
        headers: {'Content-Type': 'application/json',
          'token': '${ConstantsManager.token}'},
        body: jsonEncode(post.toJson()),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final responseBody = jsonDecode(response.body);
        throw Exception('Failed to create post: ${response.statusCode} - ${responseBody['message']}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }
}
