import 'dart:io';
import 'package:car_mate/features/my_car/pages/licence_details_screen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';

// بعد إضافة الشاشة اليدوية إلى ملفات المشروع، استوردها هنا:
import 'manual_licence_entry_screen.dart';

class UploadLicenceScreen extends StatefulWidget {
  const UploadLicenceScreen({super.key});

  @override
  State<UploadLicenceScreen> createState() => _UploadLicenceScreenState();
}

class _UploadLicenceScreenState extends State<UploadLicenceScreen> {
  String? _imagePath;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });

         }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('كاميرا'), // يمكن استخدام TextManager.camera.tr() لو لديك مفتاح في localization
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit), // أيقونة تشير إلى "إدخال يدوي"
                title: Text('إدخال يدوي'),
                onTap: () {
                  Navigator.pop(ctx);
                  // نقوم بالتنقل إلى شاشة الإدخال اليدوي
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ManualLicenceEntryScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // نتحقق من الثيم فقط إن احتجنا لتلوين حدود أو أي شيء
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('رخصتي'), // يمكنك استخدام TextManager.myCar.tr()
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, PageName.settingsScreen);
            },
            child: CustomSvgIcon(
              iconPath: AssetsManager.settingsIcon,
              size: 24,
              color: context.secondaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _showImagePickerOptions,
                child: DottedBorder(
                  color: context.secondaryColor,
                  strokeWidth: 2,
                  dashPattern: const [30, 30],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(30),
                  child: Container(
                    width: 200,
                    height: 220,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _imagePath == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add, size: 40),
                              Text(
                                'ارفع صورة الرخصة', // أو TextManager.uploadYourCarLicence.tr()
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              File(_imagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),

          // إذا تم اختيار صورة، نظهر زر "تم" للانتقال إلى التفاصيل
          if (_imagePath != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LicenceDetailsScreen(
                      licenceImagePath: _imagePath!,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: Text('تم'), // أو TextManager.done.tr()
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
