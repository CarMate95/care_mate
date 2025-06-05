// lib/features/my_car/pages/car_list_screen.dart

import 'package:flutter/material.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';

class CarListScreen extends StatelessWidget {
  final Map<String, dynamic> carData;

  const CarListScreen({Key? key, required this.carData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('تفاصيل السيارة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('تمت إضافة السيارة بنجاح!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.primaryColor,
                )),
            const SizedBox(height: 20),
            const Text(
              'بيانات السيارة المُضافة:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            // نعرض كل مفتاح وقيمته من الخريطة carData
            ...carData.entries.map((entry) {
              // يمكنك محاولة ترجمة المفتاح إلى عنوان عربي:
              String displayKey;
              switch (entry.key) {
                case 'id':
                  displayKey = 'معرّف السيارة';
                  break;
                case 'carName':
                  displayKey = 'اسم السيارة';
                  break;
                case 'carModel':
                  displayKey = 'موديل السيارة';
                  break;
                case 'nationality':
                  displayKey = 'الجنسية';
                  break;
                case 'plateNumber':
                  displayKey = 'أرقام اللوحة';
                  break;
                case 'trafficDepartment':
                  displayKey = 'قسم المرور';
                  break;
                case 'ownerName':
                  displayKey = 'اسم المالك';
                  break;
                default:
                  displayKey = entry.key;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Text(
                      '$displayKey: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const Spacer(),
            // زرّ للعودة إلى الشاشة السابقة
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'العودة',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
