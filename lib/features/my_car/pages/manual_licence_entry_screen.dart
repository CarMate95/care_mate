import 'dart:convert';

import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/constants_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_elevated_button.dart';
import 'package:car_mate/features/my_car/pages/licence_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ManualLicenceEntryScreen extends StatefulWidget {
  const ManualLicenceEntryScreen({super.key});

  @override
  State<ManualLicenceEntryScreen> createState() => _ManualLicenceEntryScreenState();
}

class _ManualLicenceEntryScreenState extends State<ManualLicenceEntryScreen> {
  final _nameController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _carTypeController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _carModelController = TextEditingController();
  final _trafficDeptController = TextEditingController();
  final _expiryDateController = TextEditingController();

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
    _expiryDateController.dispose();
    super.dispose();
  }

  Future<void> _onSavePressed() async {
    setState(() => isLoading = true);
    final token = ConstantsManager.token?.trim();
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(TextManager.noTokenPleaseLoginFirst.tr())),
      );
      setState(() => isLoading = false);
      return;
    }

    if (_nationalityController.text.trim().isEmpty ||
        _carTypeController.text.trim().isEmpty ||
        _plateNumberController.text.trim().isEmpty ||
        _carModelController.text.trim().isEmpty ||
        _trafficDeptController.text.trim().isEmpty ||
        _expiryDateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TextManager.fillYourLiecenceData.tr())),
      );
      setState(() => isLoading = false);
      return;
    }

    final manualData = {
      "carName": _carTypeController.text.trim(),
      "carModel": _carModelController.text.trim(),
      "nationality": _nationalityController.text.trim(),
      "plateNumber": _plateNumberController.text.trim(),
      "trafficDepartment": _trafficDeptController.text.trim(),
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() => isLoading = false);
        final respBody = jsonDecode(response.body) as Map<String, dynamic>?;
        if (respBody?['success'] == true && respBody?['data'] != null) {
          final id = (respBody!['data'] as Map<String, dynamic>)['id'];
          if (id != null) manualData['id'] = id.toString();
        }

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
          SnackBar(content: Text('فشل في إضافة السيارة: ${response.statusCode}')),
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء الإرسال: $e')),
      );
    }
  }

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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.tertiaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(TextManager.fillYourLiecenceData.tr()),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: TextManager.name.tr(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _nationalityController,
                        label: TextManager.nationality.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _carTypeController,
                        label: TextManager.carName.tr(),
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
                        label: TextManager.plateNumber.tr(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildTextField(
                        controller: _carModelController,
                        label: TextManager.carModel.tr(),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _trafficDeptController,
                  label: TextManager.trafficDepartment.tr(),
                ),
                const SizedBox(height: 16),
                // Pick expiry date
                _buildTextField(
                  controller: _expiryDateController,
                  label: TextManager.expiryDate.tr(),
                  readOnly: true,
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      _expiryDateController.text = DateFormat('dd/MM/yyyy').format(picked);
                      setState(() {});
                    }
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    isLoading: isLoading,
                    onPressed: _onSavePressed,
                    text: TextManager.save.tr(),
                    backgroundColor: ColorManager.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
