import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/features/repair/data/models/add_post_model.dart';
import 'package:http_parser/http_parser.dart';


class AddPostRepository {
  final String apiUrl = 'https://fb-m90x.onrender.com';
// ضيفي دي فوق

Future<AddPostModel> createPost(AddPostModel post, List<File> images) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/post/createPost'),
    );
    request.headers['token'] = '${ConstantsManager.token}';

    post.toFormData().forEach((key, value) => request.fields[key] = value);

    for (var image in images) {
      final extension = image.path.split('.').last.toLowerCase();
      final mimeType = _getMimeType(extension);

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          image.path,
          contentType: mimeType,
        ),
      );
    }

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      final decoded = jsonDecode(responseBody);
      final postJson = decoded['data']['post'];
      final userJson = decoded['data']['userdata'];

      postJson['userData'] = userJson;

      return AddPostModel.fromJson(postJson);
    } else {
      throw Exception(
        'Failed to create post: ${response.statusCode} - ${jsonDecode(responseBody)['message']}',
      );
    }
  } catch (e) {
    throw Exception('Error creating post: $e');
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
