import 'dart:convert';

import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostRepository {
  final String baseUrl = 'https://fb-m90x.onrender.com';

  Future<List<PostModel>> getOwnPosts() async {
    final response =
        await http.get(Uri.parse('$baseUrl/post/getOwnPosts/'), headers: {
      'Content-Type': 'application/json',
      'token': '${ConstantsManager.token}',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data']['posts'];
      return data.map((postJson) => PostModel.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to fetch your posts');
    }
  }

  Future<void> editPost(
  int postId,
  String newContent,
  List<String> allImages,
  int userId,
) async {
  var request = http.MultipartRequest(
    'PUT',
    Uri.parse('$baseUrl/post/updatePost/$postId'),
  );

  request.headers.addAll({
    'token': '${ConstantsManager.token}',
    'Content-Type': 'multipart/form-data',
  });

  request.fields['postContent'] = newContent;
  request.fields['userId'] = userId.toString();

  for (var imagePath in allImages) {
    if (!imagePath.startsWith('http')) {
      final extension = imagePath.split('.').last.toLowerCase();
      final mimeType = _getMimeType(extension);

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          imagePath,
          contentType: mimeType,
        ),
      );
    }
  }

  var response = await request.send();

  if (response.statusCode != 200) {
    throw Exception('Failed to edit post');
  }
}


  Future<void> deletePost(int postId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/post/deletePost/$postId'),
      headers: {'token': "${ConstantsManager.token}"},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
  MediaType _getMimeType(String extension) {
  switch (extension) {
    case 'png':
      return MediaType('image', 'png');
    case 'jpg':
    case 'jpeg':
      return MediaType('image', 'jpeg');
    case 'webp':
      return MediaType('image', 'webp');
    case 'gif':
      return MediaType('image', 'gif');
    default:
      return MediaType('application', 'octet-stream'); // fallback لأي نوع مش معروف
  }
}

}
