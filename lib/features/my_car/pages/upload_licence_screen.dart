import 'dart:io';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/my_car/pages/licence_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';


class UploadLicenceScreen extends StatefulWidget {
  const UploadLicenceScreen({Key? key}) : super(key: key);

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
        return Wrap(
          children: [
            ListTile(
              leading:  Icon(Icons.camera_alt),
              title:  Text(TextManager.camera.tr()),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading:  Icon(Icons.photo),
              title:  Text(TextManager.gallery.tr()),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(TextManager.myCar.tr()),
      ),
      body: Column(
        children: [
          // Expanded لملء المساحة المتبقية
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
                        ?  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             const  Icon (Icons.add, size: 40),
                              
                              Text( TextManager.uploadYourCarLicence.tr(),
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
          // إذا تم اختيار صورة، نظهر زر "Done" في الأسفل
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
              label:  Text(TextManager.done.tr()),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
