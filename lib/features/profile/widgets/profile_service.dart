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


static Future<Map<String, dynamic>?>updateProfile({
  String? firstName,
  String? lastName,
  String? email,
  String? phone,
  File? profilePhoto,
  required Map<String, dynamic> currentData, // البيانات الحالية قبل التحديث
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

    Map<String, String> updatedFields = {};

    // التحقق من القيم التي تغيرت فقط
    if (firstName != null && firstName != currentData['firstName']) {
      updatedFields['firstName'] = firstName;
    }
    if (lastName != null && lastName != currentData['lastName']) {
      updatedFields['lastName'] = lastName;
    }
    if (email != null && email != currentData['email']) {
      updatedFields['email'] = email;
    }
    if (phone != null && phone != currentData['phone']) {
      updatedFields['phone'] = phone;
    }

    // التأكد من أن هناك بيانات مُحدثة قبل الإرسال
    if (updatedFields.isEmpty && profilePhoto == null) {
      print('⚠️ لا توجد تغييرات لإرسالها.');
      return null;
    }

    request.fields.addAll(updatedFields);

    if (profilePhoto != null) {
      try {
        request.files.add(await http.MultipartFile.fromPath(
          'profilePhoto',
          profilePhoto.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      } catch (e) {
        print('❌ خطأ أثناء تحميل الصورة: $e');
        return {'error': 'فشل في تحميل الصورة'};
      }
    }

    print('📌 البيانات المرسلة: $updatedFields');
    print('📌 الصورة المرسلة: ${profilePhoto != null ? profilePhoto.path : "لا يوجد"}');

    var response = await request.send().timeout(Duration(seconds: 10));
    var responseBody = await response.stream.bytesToString();
    print('📌 استجابة السيرفر الكاملة: $responseBody');

    if (response.statusCode == 200) {
      return json.decode(responseBody);
    } 

    Map<String, dynamic>? errorData;
    try {
      errorData = json.decode(responseBody);
    } catch (e) {
      print('⚠️ فشل تحليل استجابة السيرفر: $responseBody');
      return {'error': 'فشل تحليل استجابة السيرفر'};
    }

    String errorMessage = '⚠️ خطأ غير معروف حدث أثناء التحديث.';
    if (errorData?['message'] != null &&
        errorData!['message'].toString().trim().isNotEmpty) {
      errorMessage = '⚠️ سبب الخطأ: ${errorData['message']}';
    }

    print(errorMessage);
    return {'error': errorMessage};

  } catch (e) {
    print('❌ خطأ أثناء تحديث البروفايل: $e');
    return {'error': 'حدث خطأ أثناء التحديث'};
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
