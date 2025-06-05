// lib/features/my_car/pages/licence_details_screen.dart

import 'dart:convert';
import 'dart:io';

import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:car_mate/features/my_car/pages/add_note_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;

class LicenceDetailsScreen extends StatefulWidget {
  /// إذا جاءت الصور عبر كاميرا OCR، نمرّر مسارها هنا
  final String? licenceImagePath;

  /// إذا جاءت البيانات يدوية (بدون حاجة لصورة)، نمرّر الخريطة بهذه الطريقة
  final Map<String, dynamic>? manualData;

  const LicenceDetailsScreen({
    Key? key,
    this.licenceImagePath,
    this.manualData,
  }) : super(key: key);

  @override
  State<LicenceDetailsScreen> createState() => _LicenceDetailsScreenState();
}

class _LicenceDetailsScreenState extends State<LicenceDetailsScreen> {
  String? _carName;
  String? _plateNumber;
  String? _expiryDate;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // إذا كانت البيانات يدوية مرسلة، نعرضها مباشرةً
    if (widget.manualData != null) {
      _populateFromManual(widget.manualData!);
    }
    // وإلا إذا وُجِد مسار صورة، نجرّي OCR
    else if (widget.licenceImagePath != null) {
      _uploadImageAndFetchDetails();
    }
  }

  /// في حالة البيانات اليدوية، نمرّرها إلى الحقول مباشرة
  void _populateFromManual(Map<String, dynamic> data) {
    setState(() {
      _carName = data['carName']?.toString() ?? '';
      _plateNumber = data['plateNumber']?.toString() ?? '';
      // قد يكون المستخدم لم يمرّر expiryDate يدويًا؛ إذا كان موجودًا في الخريطة، نعرضه
      _expiryDate = data['expiryDate']?.toString() ?? '';
      _isLoading = false;
    });
  }

  Future<void> _uploadImageAndFetchDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final uri = Uri.parse('https://carmate.smartsminds.com/api/ocr/extract_plate_info/');
    try {
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('image', widget.licenceImagePath!));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> respBody = jsonDecode(response.body);
        if (respBody['success'] == true && respBody['data'] != null) {
          final List<dynamic> blocks = respBody['data'] as List<dynamic>;
          if (blocks.isNotEmpty) {
            // استخراج أول ثلاثة حقول من البلوكات
            final firstOcr = (blocks[0]['ocr_data'] as Map<String, dynamic>)['recognized_text']?.toString() ?? '';
            String secondOcr = '';
            if (blocks.length > 1) {
              secondOcr = (blocks[1]['ocr_data'] as Map<String, dynamic>)['recognized_text']?.toString() ?? '';
            }
            String thirdOcr = '';
            if (blocks.length > 2) {
              thirdOcr = (blocks[2]['ocr_data'] as Map<String, dynamic>)['recognized_text']?.toString() ?? '';
            }
            setState(() {
              _carName = firstOcr;
              _plateNumber = secondOcr;
              _expiryDate = thirdOcr;
              _isLoading = false;
            });
          } else {
            setState(() {
              _errorMessage = 'لم يتم العثور على أي نص في الصورة';
              _isLoading = false;
            });
          }
        } else {
          setState(() {
            _errorMessage = respBody['message']?.toString() ?? 'خطأ في قراءة البيانات من الـ OCR';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'فشل في الاتصال بالخادم: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'خطأ أثناء إرسال الصورة: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth * 0.5;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(TextManager.myCar.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ============================================
            // الكارد الذي يعرض الصورة (إن وجدت) والبيانات أو حالة التحميل/الخطأ
            // ============================================
            Card(
              color: context.tertiaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // إذا أُمرر مسار الصورة، نعرضها
                  if (widget.licenceImagePath != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(
                        File(widget.licenceImagePath!),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],

                  // حالة التحميل
                  if (_isLoading) ...[
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                  ]
                  // حالة الخطأ
                  else if (_errorMessage != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      child: Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]
                  // حالة النجاح: عرض الحقول
                  else ...[
                    ListTile(
                      title: Text(
                        _carName ?? '',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'License: ${_plateNumber ?? ''}\nExpiry: ${_expiryDate ?? ''}',
                        style: const TextStyle(height: 1.4),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 15),
            // ============================================
            // الخط الفاصل
            // ============================================
            Divider(
              indent: 90,
              endIndent: 90,
              height: 55,
              color: context.secondaryColor,
              thickness: 1,
            ),

            // ============================================
            // مربع منقط لإضافة تذكير (AddNotePage)
            // ============================================
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: context.tertiaryColor,
                  builder: (_) => const AddNotePage(),
                );
              },
              child: DottedBorder(
                color: context.secondaryColor,
                strokeWidth: 2,
                dashPattern: const [30, 30],
                borderType: BorderType.RRect,
                radius: const Radius.circular(30),
                child: Container(
                  width: containerSize,
                  height: containerSize,
                  alignment: Alignment.center,
                  child: const Icon(Icons.add, size: 40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
