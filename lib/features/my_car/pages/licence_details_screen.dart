import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/my_car/pages/add_note_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';


class LicenceDetailsScreen extends StatefulWidget {
  final String licenceImagePath;

  const LicenceDetailsScreen({
    Key? key,
    required this.licenceImagePath,
  }) : super(key: key);

  @override
  State<LicenceDetailsScreen> createState() => _LicenceDetailsScreenState();
}

class _LicenceDetailsScreenState extends State<LicenceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final carName = "Seat Leon";
    final licenseNumber = "1234567";
    final expiryDate = "12/2025";

    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth * 0.5;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(TextManager.myCar.tr()),  
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // كارد عرض بيانات السيارة
            Card(
                color: context.tertiaryColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/Hatchback Mockup 01.png', // يتم تمرير مسار الصورة من الخارج
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      carName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'License: $licenseNumber\nExpiry: $expiryDate',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // نص التذكيرات
             Divider(
              indent: 90,
              endIndent: 90,
              height: 55,
              color: context.secondaryColor,
              thickness: 1,),

            // مربع منقط لفتح نافذة AddNotePage
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierColor: context.tertiaryColor, // بدون خلفية سوداء
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
