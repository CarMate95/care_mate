import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:car_mate/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:car_mate/features/layout/presentation/widgets/custom_layout_button_nav_bar.dart';
import 'package:car_mate/features/my_car/pages/add_note_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicenceDetailsScreen extends StatefulWidget {
  final String licenceImagePath;

  const LicenceDetailsScreen({
    super.key,
    required this.licenceImagePath,
  });

  @override
  State<LicenceDetailsScreen> createState() => _LicenceDetailsScreenState();
}

class _LicenceDetailsScreenState extends State<LicenceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    const carName = "Seat Leon";
    const licenseNumber = "1234567";
    const expiryDate = "12/2025";

    final screenWidth = MediaQuery.of(context).size.width;
    final containerSize = screenWidth * 0.5;
final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
     appBar: AppBar(
        centerTitle: true,
        title: Text(TextManager.myCar.tr()),
        actions:
             [
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

              ]
            
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
                  const ListTile(
                    title: Text(
                      carName,
                      style: TextStyle(
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
              thickness: 1,
            ),

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
