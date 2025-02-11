import 'dart:ui'; 
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/my_car/pages/notes_list_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';



class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);
 
  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final Widget trailing;
  const SettingsOption({Key? key, required this.icon, required this.trailing}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      trailing: trailing,
    );
  }
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _cashController = TextEditingController();
  final _noteController = TextEditingController();

  bool _notifyMe = false; // حالة "Notify Me"

  @override
  Widget build(BuildContext context) {
    var saveText = TextManager.save.tr();
    var fillText = TextManager.fillYourReminderData.tr();

    return Dialog(
      backgroundColor: context.tertiaryColor, // خلفية الـDialog شفافة
      insetPadding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          // خلفية ضبابية
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: context.tertiaryColor),
            ),
          ),
          // محتوى النافذة في المنتصف
          Center(
            child: _buildPopupContent(context, fillText, saveText),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupContent(
      BuildContext context, String fillText, String saveText) {
    return Card(
      color: context.scaffoldBackgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // العنوان الرئيسي
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

              // حقلا تاريخ البداية والنهاية
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _startDateController,
                      label: TextManager.startDate.tr(),
                      readOnly: true,
                      onTap: () => _pickStartDate(_startDateController),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      controller: _endDateController,
                      label: TextManager.endDate.tr(),
                      readOnly: true,
                      onTap: () => _pickEndDate(_endDateController),
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
                label: TextManager.title.tr(),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // زر الحفظ
              SizedBox(
                height: 48,
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

  Future<void> _pickStartDate(TextEditingController controller) async {
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

  Future<void> _pickEndDate(TextEditingController controller) async {
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

  void _onSavePressed() {
    final newNote = {
      "title": _titleController.text,
      "startDate": _startDateController.text,
      "endDate": _endDateController.text,
      "cash": _cashController.text,
      "note": _noteController.text,
      "notifyMe": _notifyMe.toString(),
    };

    Navigator.pop(context); // إغلاق الديالوج

    // الانتقال لشاشة عرض الملاحظات دون تمرير معلومات عن الثيم أو اللغة
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NotesListScreen(
          reminderData: newNote,
        ),
      ),
    );
  }
}
