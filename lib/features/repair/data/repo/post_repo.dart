// post_repository.dart

import 'dart:convert';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String baseUrl = 'https://fb-m90x.onrender.com';

  Future<List<PostModel>> getAllPosts() async {
    final response =
        await http.get(Uri.parse('$baseUrl/post/getAllPosts?size=1000000'), headers: {
      'Content-Type': 'application/json',
      'token': '${ConstantsManager.token}',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((postJson) => PostModel.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }


  Future<List<PostModel>> getOwnPosts(int userId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/post/getOwnPosts/$userId'), headers: {
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
}
