import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/features/layout/presentation/cubit/layout_cubit.dart';
import 'package:car_mate/features/layout/presentation/widgets/custom_layout_button_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Map<String, String> note;

  const NoteDetailsScreen({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final title = note['title'] ?? '';
    final startDate = note['startDate'] ?? '';
    final endDate = note['endDate'] ?? '';
    final cash = note['cash'] ?? '';
    final noteBody = note['note'] ?? '';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(TextManager.noteDetails.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // يمكن استخدام ListView إذا كانت التفاصيل كثيرة
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextManager.title.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(title),
            const SizedBox(height: 16),
            Text(
              TextManager.start.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('$startDate  '),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Text(
              TextManager.end.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('  $endDate'),
            const SizedBox(height: 16),
            Text(
              TextManager.cash.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(cash),
            const SizedBox(height: 16),
            Text(
              TextManager.note.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(noteBody),
            const SizedBox(height: 16),
          ],
        ),
      ),
     
    );
  }
}
