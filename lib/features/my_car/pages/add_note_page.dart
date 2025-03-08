import 'dart:convert';
import 'dart:ui';

import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/my_car/pages/notes_list_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// إذا لديك ملف ConstantsManager حيث يوجد token، استورده هكذا:
// import 'package:your_app_path/core/utils/constants_manager.dart';
import 'package:car_mate/core/utils/constants_manager.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  // Controllers للحقول
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _cashController = TextEditingController();
  final _noteController = TextEditingController();

  // مثال: إذا كنت تريد حقل إضافي كـ notifyMe
  final bool _notifyMe = false;

  // رابط الـ API الأساسي
  final String baseUrl = 'https://fb-m90x.onrender.com';
  // اسم المسار (Endpoint) للإضافة
  final String endpoint = '/user/addreminder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextManager.addNote.tr()),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var saveText = TextManager.save.tr();
    var fillText = TextManager.fillYourReminderData.tr();

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fillText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // حقل العنوان
              _buildTextField(
                controller: _titleController,
                label: TextManager.title.tr(),
              ),
              const SizedBox(height: 16),

              // حقل التاريخين
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _startDateController,
                      label: TextManager.startDate.tr(),
                      readOnly: true,
                      onTap: () => _pickDate(_startDateController),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      controller: _endDateController,
                      label: TextManager.endDate.tr(),
                      readOnly: true,
                      onTap: () => _pickDate(_endDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // حقل المبلغ
              _buildTextField(
                controller: _cashController,
                label: TextManager.cash.tr(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // حقل الملاحظة
              _buildTextField(
                controller: _noteController,
                label: TextManager.note.tr(),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // زر الحفظ
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _onSavePressed,
                  child: Text(
                    saveText,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// عنصر TextField مخصص
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      style: TextStyle(color: context.secondaryColor),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(color: context.secondaryColor.withOpacity(0.7)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.tertiaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// التقاط تاريخ ووضعه في الـ Controller
  Future<void> _pickDate(TextEditingController controller) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formatted = '${picked.year}/${picked.month}/${picked.day}';
      setState(() {
        controller.text = formatted;
      });
    }
  }

  /// دالة حفظ البيانات وإرسالها إلى السيرفر
  Future<void> _onSavePressed() async {
    // 1) استخرج التوكن من ConstantsManager
    String? token = ConstantsManager.token?.trim();
    if (token == null || token.isEmpty) {
      print('⚠ لا يوجد توكين مخزن');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('لا يوجد توكين مخزن، سجل دخول أولاً'),
        ),
      );
      return;
    }

    // 2) جهّز البيانات في شكل Map
    final newNote = {
      "title": _titleController.text,
      "startDate": _startDateController.text,
      "endDate": _endDateController.text,
      "cash": _cashController.text,
      "note": _noteController.text,
      
    };

    print('DEBUG: Sending data = $newNote');

    try {
      // 3) كوّن الرابط النهائي
      final url = Uri.parse(baseUrl + endpoint);

      // 4) جهّز الهيدرز
      final headers = {
        'token': token,
        'Content-Type': 'application/json',
      };

      // 5) نفّذ الطلب
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(newNote),
      );

      print('DEBUG: Response statusCode = ${response.statusCode}');
      print('DEBUG: Response body = ${response.body}');

      // 6) تحقق من رمز الحالة
      if (response.statusCode == 200 || response.statusCode == 201) {
        // إذا كان الرد:
        // {
        //   "success": true,
        //   "message": "reminder created successfully",
        //   "data": {
        //     "id": 18,
        //     ...
        //   }
        // }

        // 7) نفكك الـ JSON
        final bodyMap = jsonDecode(response.body);
        if (bodyMap is Map<String, dynamic>) {
          final dataObj = bodyMap['data'];
          if (dataObj is Map<String, dynamic>) {
            final id = dataObj['id'];
            if (id != null) {
              // نخزن الـ id في newNote
              newNote['id'] = id.toString();
            }
          }
        }

        // 8) نجاح -> انتقل للشاشة التالية مع تمرير newNote
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NotesListScreen(reminderData: newNote),
          ),
        );
      } else {
        // فشل
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في الإضافة: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // أي خطأ آخر (مثل انقطاع الإنترنت)
      print('DEBUG: Exception = $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطأ أثناء الإرسال: $e'),
        ),
      );
    }
  }
}
