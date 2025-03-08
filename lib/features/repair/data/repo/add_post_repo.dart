import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/add_post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AddPostRepository {
  final String apiUrl = 'https://fb-m90x.onrender.com';

  Future<Map<String, dynamic>> createPost(
      AddPostModel post, List<File> images) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$apiUrl/post/createPost'));
      request.headers['token'] = '${ConstantsManager.token}';

      post.toFormData().forEach((key, value) => request.fields[key] = value);
      for (var image in images) {
        request.files
            .add(await http.MultipartFile.fromPath('images', image.path));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        print('API Response: $responseBody');
        if (responseBody.isNotEmpty) {
          return jsonDecode(responseBody);
        } else {
          throw Exception('Post created, but no response body returned.');
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        throw Exception(
            'Failed to create post: ${response.statusCode} - ${jsonDecode(responseBody)['message']}');
      }
    } catch (e) {
      throw Exception('Error creating post: $e');
    }
  }
}
