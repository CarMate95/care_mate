// lib/features/my_car/pages/manual_licence_entry_screen.dart

import 'dart:convert';

import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
// استورد شاشة التفاصيل التي عدّلناها
import 'package:car_mate/features/my_car/pages/licence_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../config/themes/text_manager.dart';

class ManualLicenceEntryScreen extends StatefulWidget {
  const ManualLicenceEntryScreen({super.key});

  @override
  State<ManualLicenceEntryScreen> createState() =>
      _ManualLicenceEntryScreenState();
}

class _ManualLicenceEntryScreenState extends State<ManualLicenceEntryScreen> {
  final TextEditingController _nameController =
      TextEditingController(); // (اختياري)
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _carTypeController = TextEditingController();
  final TextEditingController _plateNumberController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  final TextEditingController _trafficDeptController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  // رابط الـ API الأساسي والمسار
  final String baseUrl = 'https://fb-m90x.onrender.com';
  final String endpoint = '/user/addcar';

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nationalityController.dispose();
    _carTypeController.dispose();
    _plateNumberController.dispose();
    _carModelController.dispose();
    _trafficDeptController.dispose();
    super.dispose();
  }

  Future<void> _onSavePressed() async {
    setState(() => isLoading = true);
    String? token = ConstantsManager.token?.trim();
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد توكين مخزن، سجلّ الدخول أولًا')),
      );
      return;
    }

    if (_nationalityController.text.trim().isEmpty ||
        _carTypeController.text.trim().isEmpty ||
        _plateNumberController.text.trim().isEmpty ||
        _carModelController.text.trim().isEmpty ||
        _trafficDeptController.text.trim().isEmpty ||
        _expiryDateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تعبئة جميع الحقول')),
      );
      return;
    }

    final Map<String, dynamic> manualData = {
      "carName": _carTypeController.text.trim(),
      "carModel": _carModelController.text.trim(),
      "nationality": _nationalityController.text.trim(),
      "plateNumber": _plateNumberController.text.trim(),
      "trafficDepartment": _trafficDeptController.text.trim(),
      // "ownerName": _nameController.text.trim(),  // اختياري
      "expiry": _expiryDateController.text.trim(),
    };

    try {
      final uri = Uri.parse(baseUrl + endpoint);
      final headers = {
        'Content-Type': 'application/json',
        'token': token,
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(manualData),
      );

      debugPrint('🔸 addCar status code: ${response.statusCode}');
      debugPrint('🔸 addCar response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() => isLoading = false);
        // نأخذ الـ id من الرد ونضيفه إلى manualData (اختياري إن لزمّ)
        final Map<String, dynamic> respBody = jsonDecode(response.body);
        if (respBody['success'] == true && respBody['data'] != null) {
          final id = (respBody['data'] as Map<String, dynamic>)['id'];
          if (id != null) {
            manualData['id'] = id.toString();
          }
        }

        // 9) ننقل إلى LicenceDetailsScreen ولكن مع تمرير manualData (بدون مسار صورة)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LicenceDetailsScreen(
              licenceImagePath: null,
              manualData: manualData,
            ),
          ),
        );
      } else {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('فشل في إضافة السيارة: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint('❗Exception during addCar: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء الإرسال: $e')),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    void Function()? onTap,
  }) {
    return TextField(
      onTap: onTap,
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: context.secondaryColor.withOpacity(0.8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: context.primaryColor),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('املأ بيانات رخصتك'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 8, offset: Offset(0, 3)),
              ],
            ),
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameController,
                  labelText: 'الاسم (اختياري)',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _nationalityController,
                        labelText: 'الجنسية',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _carTypeController,
                        labelText: 'اسم السيارة',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _plateNumberController,
                        labelText: 'أرقام اللوحة',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _carModelController,
                        labelText: 'موديل السيارة',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _trafficDeptController,
                  labelText: 'قسم المرور',
                ),
                const SizedBox(height: 24),

                // expiration date picker
                InkWell(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime(2100),
                    ).then((value) {
                      if (value != null) {
                        _expiryDateController.text =
                            DateFormat('dd/MM/yyyy').format(value);
                        setState(() {});
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Text(
                      _expiryDateController.text.isEmpty
                          ? 'تاريخ الانتهاء'
                          : _expiryDateController.text,
                      style: getMediumStyle(color: Colors.black),
                    ),
                  ),
                ),

                // ),
                const SizedBox(height: 24),
                CustomElevatedButton(
                  isLoading: isLoading,
                  onPressed: _onSavePressed,
                  text: TextManager.save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
