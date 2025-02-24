import 'dart:convert';
import 'dart:io';
import 'package:car_mate/core/api/end_points.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfileService {
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      String? token = ConstantsManager.token?.trim();
      if (token == null || token.isEmpty) {
        print('⚠️ لا يوجد توكين مخزن');
        return null;
      }

      final response = await http.get(
        Uri.parse(EndPoints.baseUrl + EndPoints.profile),
        headers: {
          'token': token,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['data'];
      } else {
        print('❌ فشل تحميل البيانات، كود: ${response.statusCode}');
        print('📌 Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('❌ خطأ أثناء تحميل البروفايل: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    File? profilePhoto,
  }) async {
    try {
      String? token = ConstantsManager.token?.trim();
      if (token == null || token.isEmpty) {
        print('⚠️ لا يوجد توكين مخزن');
        return null;
      }

      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(EndPoints.baseUrl + EndPoints.update),
      );

      request.headers.addAll({
        'token': token,
        'Accept': 'application/json',
      });

      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['email'] = email;
      request.fields['phone'] = phone;

      if (profilePhoto != null) {
        try {
          request.files.add(await http.MultipartFile.fromPath(
            'profilePhoto',
            profilePhoto.path,
            contentType: MediaType('image', 'jpeg'),
          ));
        } catch (e) {
          print('❌ خطأ أثناء تحميل الصورة: $e');
          return null;
        }
      }
      print('📌 البيانات المرسلة: ${request.fields}');
      print('📌 الصورة المرسلة: ${request.files}');

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print('📌 استجابة السيرفر الكاملة: $responseBody');

      print('📌 Response Status Code: ${response.statusCode}');
      print('📌 Response Body: $responseBody');

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else if (response.statusCode == 409) {
        print('❌ خطأ 409: يوجد تعارض في البيانات.');
        Map<String, dynamic>? errorData;

        try {
          errorData = json.decode(responseBody);
        } catch (e) {
          print('⚠️ فشل تحليل استجابة السيرفر.');
          print('📌 البيانات المستلمة: $responseBody');
          return null;
        }

        print('📌 تفاصيل الخطأ: $errorData');

        String errorMessage =
            "⚠️ يوجد تعارض في البيانات، ربما البريد الإلكتروني أو الهاتف مسجل مسبقًا.";

        if (errorData?['message'] != null &&
            errorData!['message'].toString().trim().isNotEmpty) {
          errorMessage = '⚠️ سبب الخطأ: ${errorData['message']}';
        } else {
          print('⚠️ لم يقدم السيرفر سببًا واضحًا للخطأ.');
        }

        print(errorMessage);
        return null;
      } else {
        print('❌ فشل التحديث، كود: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('❌ خطأ أثناء تحديث البروفايل: $e');
      return null;
    }
  }

  static Future<bool> deleteProfile() async {
  try {
    String? token = ConstantsManager.token?.trim();
    if (token == null || token.isEmpty) {
      print('⚠️ لا يوجد توكين مخزن');
      return false;
    }

    final response = await http
        .delete(
          Uri.parse(EndPoints.baseUrl + EndPoints.delete),
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
        )
        .timeout(const Duration(seconds: 10));

    print('📌 Response Status Code: ${response.statusCode}');
    print('📌 Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('✅ تم حذف الحساب بنجاح');
      return true;
    } else {
      print('❌ فشل حذف الحساب، كود: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('❌ خطأ أثناء حذف الحساب: $e');
    return false;
  }
}

}
