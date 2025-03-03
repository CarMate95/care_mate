import 'dart:ui';
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:car_mate/features/my_car/pages/NoteDetailsScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotesListScreen extends StatefulWidget {
  final Map<String, String>? reminderData;

  const NotesListScreen({
    super.key,
    this.reminderData,
  });

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  // القائمة الكاملة للملاحظات
  final List<Map<String, String>> _notes = [];

  // القائمة المفلترة حسب البحث
  List<Map<String, String>> _filteredNotes = [];

  // للتحكم في نص البحث
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // إضافة الملاحظة القادمة من صفحة AddNotePage إن وجدت
    if (widget.reminderData != null) {
      _notes.add(widget.reminderData!);
    }
    _filteredNotes = List.from(_notes);

    _searchController.addListener(_filterNotes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterNotes);
    _searchController.dispose();
    super.dispose();
  }

  // تصفية الملاحظات بحسب نص البحث
  void _filterNotes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredNotes = _notes.where((note) {
        final title = note['title']?.toLowerCase() ?? '';
        final noteBody = note['note']?.toLowerCase() ?? '';
        return title.contains(query) || noteBody.contains(query);
      }).toList();
    });
  }

  // إضافة ملاحظة جديدة إلى القائمة
  void _addNote(Map<String, String> newNote) {
    setState(() {
      _notes.add(newNote);
      _filterNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    const carName = "Seat Leon";
    const licenseNumber = "1234567";
    const expiryDate = "12/2025";

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(TextManager.myCar.tr()),
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
          ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // بطاقة عرض بيانات السيارة
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
                      'assets/images/Hatchback Mockup 01.png',
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
            const SizedBox(height: 20),
            // حقل البحث
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: context.tertiaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: context.secondaryColor),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: context.tertiaryColor,
                      ),
                      labelText: TextManager.searchForYourReminders.tr(),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: context.tertiaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // زر إضافة ملاحظة
                ElevatedButton(
                  onPressed: () {
                    _showAddNotePopup();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: context.tertiaryColor,
                  ),
                  child: Icon(
                    Icons.add,
                    color: context.secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // عرض الملاحظات المفلترة
            Expanded(
              child: _filteredNotes.isEmpty
                  ? Center(
                      child: Text(
                        TextManager.noNotesFound.tr(),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = _filteredNotes[index];
                        return Card(
                          color: context.tertiaryColor,
                          child: ListTile(
                            title: Text(note['title'] ?? ''),
                            subtitle: Text(
                              '${note['startDate']} - ${note['endDate']}\n${note['note']}',
                            ),
                            trailing: Text(note['cash'] ?? ''),
                            onLongPress: () => _confirmDeleteNote(index),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NoteDetailsScreen(
                                    note: note,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // فتح النافذة لإضافة ملاحظة جديدة
  void _showAddNotePopup() async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierColor: context.tertiaryColor,
      builder: (_) {
        return const _AddNotePopup();
      },
    );
    if (result != null) {
      _addNote(result);
    }
  }

  // تأكيد حذف الملاحظة
  Future<void> _confirmDeleteNote(int index) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.tertiaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          TextManager.deleteNote.tr(),
        ),
        content: Text(
          TextManager.deleteWarningNote.tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              TextManager.cancel.tr(),
              style: TextStyle(
                color: context.secondaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              TextManager.ok.tr(),
              style: TextStyle(
                color: context.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() {
        _notes.removeAt(index);
        _filterNotes();
      });
    }
  }
}

class _AddNotePopup extends StatefulWidget {
  const _AddNotePopup({super.key});

  @override
  State<_AddNotePopup> createState() => _AddNotePopupState();
}

class _AddNotePopupState extends State<_AddNotePopup> {
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _cashController = TextEditingController();
  final _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    var saveText = TextManager.save.tr();
    var fillText = TextManager.fillYourReminderData.tr();

    return Dialog(
      backgroundColor: context.tertiaryColor,
      insetPadding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: context.tertiaryColor),
            ),
          ),
          Center(
            child: _buildPopupContent(context, fillText, saveText, isLightMode),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupContent(BuildContext context, String fillText,
      String saveText, bool isLightMode) {
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
              Text(
                fillText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.secondaryColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_titleController, 'Title', isLightMode),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _startDateController,
                      'Start Date',
                      isLightMode,
                      readOnly: true,
                      onTap: () => _pickDate(_startDateController),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      _endDateController,
                      'End Date',
                      isLightMode,
                      readOnly: true,
                      onTap: () => _pickDate(_endDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _cashController,
                      'Cash',
                      isLightMode,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(_noteController, 'Note', isLightMode,
                  maxLines: 3),
              const SizedBox(height: 16),
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

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool isLightMode, {
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
        // ignore: deprecated_member_use
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

  Future<void> _pickDate(TextEditingController controller) async {
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
    };
    Navigator.pop(context, newNote);
  }
}
