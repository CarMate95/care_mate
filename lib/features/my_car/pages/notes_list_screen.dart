import 'dart:ui';
import 'dart:developer' as developer;
import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:car_mate/core/utils/constants_manager.dart';

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
  final List<Map<String, String>> _notes = [];
  List<Map<String, String>> _filteredNotes = [];

  final TextEditingController _searchController = TextEditingController();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fb-m90x.onrender.com', // عدّل الرابط لو لديك رابط مختلف
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  bool _isLoading = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();

    // إضافة LogInterceptor لعرض الطلبات والاستجابات في الـ Console
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    // إذا أتت ملاحظة من شاشة الإضافة (AddNotePopup)
    if (widget.reminderData != null) {
      _notes.add(widget.reminderData!);
      print('DEBUG: أُضيفت ملاحظة من شاشة أخرى: ${widget.reminderData}');
    }

    // جلب الملاحظات من السيرفر
    _fetchNotesFromServer();

    // تهيئة القائمة المفلترة
    _filteredNotes = List.from(_notes);

    // ربط دالة التصفية بحقل البحث
    _searchController.addListener(_filterNotes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterNotes);
    _searchController.dispose();
    super.dispose();
  }

  /// جلب الملاحظات من السيرفر
  Future<void> _fetchNotesFromServer() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    try {
      developer.log('DEBUG (fetch): بدأنا جلب الملاحظات');

      // طباعة التوكن للتأكد من أنه هو المستخدم في Postman
      developer.log('DEBUG (fetch): current token = ${ConstantsManager.token}');

      String? token = ConstantsManager.token?.trim();
      if (token == null || token.isEmpty) {
        print('⚠ لا يوجد توكين مخزن');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد توكين مخزن، سجل دخول أولاً')),
        );
        setState(() => _isLoading = false);
        return;
      }

      final response = await _dio.get(
        '/user/getreminder',
        options: Options(
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      developer.log('DEBUG (fetch): statusCode = ${response.statusCode}');
      developer.log('DEBUG (fetch): response.data = ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        // نتوقع هيكل مثل:
        // {
        //   "success": true,
        //   "message": "reminder retrieved successfully",
        //   "data": [ {...}, {...} ]
        // }
        if (data is Map<String, dynamic>) {
          final innerList = data['data'];
          if (innerList is List) {
            _notes.clear();
            for (var item in innerList) {
              if (item is Map<String, dynamic>) {
                _notes.add({
                  'id': item['id']?.toString() ?? '',
                  // تنسيق التواريخ
                  'startDate':
                      _formatIsoDate(item['startDate']?.toString() ?? ''),
                  'endDate': _formatIsoDate(item['endDate']?.toString() ?? ''),
                  'title': item['title']?.toString() ?? '',
                  'cash': item['cash']?.toString() ?? '',
                  'note': item['note']?.toString() ?? '',
                });
              }
            }
            developer.log('DEBUG (fetch): _notes = $_notes');
            _filterNotes();
          } else {
            developer.log('DEBUG (fetch): data["data"] ليس مصفوفة!');
          }
        } else {
          developer.log('DEBUG (fetch): response.data ليس كائن Map!');
        }
      } else {
        _isError = true;
      }
    } on DioException catch (e) {
      _isError = true;
      developer.log('DEBUG (fetch): DioError = ${e.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// دالة لتنسيق التاريخ ISO 8601 (مثل 2025-03-26T00:00:00.000Z) إلى شكل أبسط
  String _formatIsoDate(String isoString) {
    if (isoString.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoString);
      // اختر الصيغة التي تريدها
      return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
    } catch (e) {
      // لو صار خطأ في التحويل، ارجع نفس النص
      return isoString;
    }
  }

  /// تصفية الملاحظات
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

  /// إضافة ملاحظة جديدة محليًا
  void _addNote(Map<String, String> newNote) {
    setState(() {
      _notes.add(newNote);
      developer.log('DEBUG (addNote): _notes = $_notes');
      _filterNotes();
    });
  }

  /// تحديث ملاحظة محليًا
  void _updateNoteLocally(String id, Map<String, String> updatedData) {
    final index = _notes.indexWhere((note) => note['id'] == id);
    if (index != -1) {
      setState(() {
        _notes[index] = updatedData;
        developer.log('DEBUG (updateNoteLocally): _notes = $_notes');
        _filterNotes();
      });
    }
  }

  /// عرض Popup لإضافة ملاحظة
  void _showAddNotePopup() async {
    developer.log('DEBUG: ضغط على زر + لإضافة ملاحظة');
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierColor: context.tertiaryColor.withOpacity(0.2),
      builder: (_) {
        return const _AddNotePopup();
      },
    );
    if (result != null) {
      _addNote(result);
    }
  }

  /// عرض Popup لتعديل ملاحظة
  void _showEditNotePopup(Map<String, String> note) async {
    developer.log('DEBUG: ضغط على زر Edit للملاحظة: $note');
    final result = await showDialog<Map<String, String>>(
      context: context,
      barrierColor: context.tertiaryColor.withOpacity(0.2),
      builder: (_) {
        return _EditNotePopup(note: note);
      },
    );
    if (result != null) {
      final noteId = note['id'] ?? '';
      _updateNoteLocally(noteId, result);
    }
  }

  /// تأكيد الحذف
  Future<void> _confirmDeleteNote(Map<String, String> note) async {
    developer.log('DEBUG: ضغط على زر Delete للملاحظة: $note');

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.tertiaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          TextManager.deleteNote.tr(),
          style: TextStyle(color: context.secondaryColor),
        ),
        content: Text(
          TextManager.deleteWarningNote.tr(),
          style: TextStyle(color: context.secondaryColor),
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
      try {
        String? token = ConstantsManager.token?.trim();
        if (token == null || token.isEmpty) {
          print('⚠ لا يوجد توكين');
          return;
        }

        final noteId = note['id'] ?? '';
        developer.log('DEBUG (delete): noteId = $noteId');
        final response = await _dio.delete(
          '/user/deletereminder/$noteId',
          options: Options(
            headers: {
              'token': token,
              'Content-Type': 'application/json',
            },
          ),
        );
        developer.log('DEBUG (delete): statusCode = ${response.statusCode}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          setState(() {
            _notes.removeWhere((n) => n['id'] == noteId);
            developer.log('DEBUG (delete): بعد الحذف = $_notes');
            _filterNotes();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل الحذف: ${response.statusCode}')),
          );
        }
      } on DioException catch (e) {
        developer.log('DEBUG (delete): DioError = ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الحذف: ${e.message}')),
        );
      }
    }
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
        ],
      ),
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
                  ListTile(
                    title: const Text(
                      carName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'License: $licenseNumber\nExpiry: $expiryDate',
                      style: TextStyle(color: context.secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // حقل البحث + زر إضافة
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
                ElevatedButton(
                  onPressed: _showAddNotePopup,
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

            // عرض الملاحظات
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _isError
                      ? Center(
                          child: Text(
                            'Error fetching notes!',
                            style: TextStyle(color: context.secondaryColor),
                          ),
                        )
                      : _filteredNotes.isEmpty
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                note['title'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: context.secondaryColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            InkWell(
                                              onTap: () {
                                                developer.log(
                                                  'DEBUG: onTap Edit للملاحظة: $note',
                                                );
                                                _showEditNotePopup(note);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: context.isDarkMode
                                                      ? Colors.grey[800]
                                                      : Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                child: Text(
                                                  TextManager.edit.tr(),
                                                  style: TextStyle(
                                                    color:
                                                        context.secondaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            InkWell(
                                              onTap: () {
                                                developer.log(
                                                  'DEBUG: onTap Delete للملاحظة: $note',
                                                );
                                                _confirmDeleteNote(note);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      ColorManager.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                child: Text(
                                                  TextManager.deleteNote.tr(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text(
                                              note['startDate'] ?? '',
                                              style: TextStyle(
                                                  color:
                                                      context.secondaryColor),
                                            ),
                                            const SizedBox(width: 8),
                                            Row(
                                              children: [
                                                _buildColoredDot(Colors.blue),
                                                _buildColoredDot(Colors.red),
                                                _buildColoredDot(Colors.blue),
                                                _buildColoredDot(Colors.red),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              note['endDate'] ?? '',
                                              style: TextStyle(
                                                  color:
                                                      context.secondaryColor),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        if ((note['note'] ?? '').isNotEmpty)
                                          Text(
                                            note['note']!,
                                            style: TextStyle(
                                              color: context.secondaryColor,
                                            ),
                                          ),
                                      ],
                                    ),
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

  Widget _buildColoredDot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// نافذة (Dialog) لإضافة ملاحظة جديدة
class _AddNotePopup extends StatefulWidget {
  const _AddNotePopup({Key? key}) : super(key: key);

  @override
  State<_AddNotePopup> createState() => _AddNotePopupState();
}

class _AddNotePopupState extends State<_AddNotePopup> {
  final _titleController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _cashController = TextEditingController();
  final _noteController = TextEditingController();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fb-m90x.onrender.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: Container(color: context.tertiaryColor.withOpacity(0.5)),
            ),
          ),
          Center(
            child: _buildPopupContent(context, fillText, saveText),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupContent(
    BuildContext context,
    String fillText,
    String saveText,
  ) {
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
              _buildTextField(_titleController, 'Title'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _startDateController,
                      'Start Date',
                      readOnly: true,
                      onTap: () => _pickDate(_startDateController),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      _endDateController,
                      'End Date',
                      readOnly: true,
                      onTap: () => _pickDate(_endDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _cashController,
                'Cash',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _noteController,
                'Note',
                maxLines: 3,
              ),
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
                  onPressed: _isLoading ? null : _onSavePressed,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          saveText,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
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
    String label, {
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

  Future<void> _onSavePressed() async {
    final newNote = {
      "title": _titleController.text,
      "startDate": _startDateController.text,
      "endDate": _endDateController.text,
      "cash": _cashController.text,
      "note": _noteController.text,
    };

    setState(() => _isLoading = true);

    try {
      developer.log('DEBUG (add): newNote = $newNote');

      String? token = ConstantsManager.token?.trim();
      if (token == null || token.isEmpty) {
        print('⚠ لا يوجد توكين مخزن');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد توكين مخزن، سجل دخول أولاً')),
        );
        setState(() => _isLoading = false);
        return;
      }

      final response = await _dio.post(
        '/user/addreminder',
        data: newNote,
        options: Options(
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      developer.log('DEBUG (add): statusCode = ${response.statusCode}');
      developer.log('DEBUG (add): response.data = ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final dataObj = responseData['data'];
          if (dataObj is Map<String, dynamic>) {
            final id = dataObj['id'];
            if (id != null) {
              newNote['id'] = id.toString();
            }
          }
        }
        Navigator.pop(context, newNote);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل الإضافة: ${response.statusCode}')),
        );
      }
    } on DioException catch (e) {
      print('DEBUG (add): DioError = ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في الإرسال: ${e.message}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}

/// نافذة (Dialog) لتعديل ملاحظة
class _EditNotePopup extends StatefulWidget {
  final Map<String, String> note;

  const _EditNotePopup({Key? key, required this.note}) : super(key: key);

  @override
  State<_EditNotePopup> createState() => _EditNotePopupState();
}

class _EditNotePopupState extends State<_EditNotePopup> {
  late TextEditingController _titleController;
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;
  late TextEditingController _cashController;
  late TextEditingController _noteController;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fb-m90x.onrender.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    _titleController = TextEditingController(text: widget.note['title'] ?? '');
    _startDateController =
        TextEditingController(text: widget.note['startDate'] ?? '');
    _endDateController =
        TextEditingController(text: widget.note['endDate'] ?? '');
    _cashController = TextEditingController(text: widget.note['cash'] ?? '');
    _noteController = TextEditingController(text: widget.note['note'] ?? '');
  }

  @override
  Widget build(BuildContext context) {
    var updateText = "Update";
    var editTitle = "Edit your reminder";

    return Dialog(
      backgroundColor: context.tertiaryColor,
      insetPadding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: context.tertiaryColor.withOpacity(0.5)),
            ),
          ),
          Center(
            child: _buildPopupContent(context, editTitle, updateText),
          ),
        ],
      ),
    );
  }

  Widget _buildPopupContent(
      BuildContext context, String editTitle, String updateText) {
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
            children: [
              Text(
                editTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.secondaryColor,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(_titleController, 'Title'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      _startDateController,
                      'Start Date',
                      readOnly: true,
                      onTap: () => _pickDate(_startDateController),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildTextField(
                      _endDateController,
                      'End Date',
                      readOnly: true,
                      onTap: () => _pickDate(_endDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _cashController,
                'Cash',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                _noteController,
                'Note',
                maxLines: 3,
              ),
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
                  onPressed: _isLoading ? null : _onUpdatePressed,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          updateText,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
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
    String label, {
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

  Future<void> _onUpdatePressed() async {
    final updatedNote = {
      "id": widget.note['id'] ?? '',
      "title": _titleController.text,
      "startDate": _startDateController.text,
      "endDate": _endDateController.text,
      "cash": _cashController.text,
      "note": _noteController.text,
    };

    setState(() => _isLoading = true);

    try {
      developer.log('DEBUG (update): updatedNote = $updatedNote');

      String? token = ConstantsManager.token?.trim();
      if (token == null || token.isEmpty) {
        print('⚠ لا يوجد توكين مخزن');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد توكين مخزن، سجل دخول أولاً')),
        );
        setState(() => _isLoading = false);
        return;
      }

      final noteId = widget.note['id'] ?? '';
      developer.log('DEBUG (update): noteId = $noteId');
      developer.log('DEBUG (update): endpoint = /user/updatereminder/$noteId');

      final response = await _dio.put(
        '/user/updatereminder/$noteId', // عدّل لو السيرفر يختلف
        data: updatedNote,
        options: Options(
          headers: {
            'token': token,
            'Content-Type': 'application/json',
          },
        ),
      );

      developer.log('DEBUG (update): statusCode = ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context, updatedNote);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل التعديل: ${response.statusCode}')),
        );
      }
    } on DioException catch (e) {
      print('DEBUG (update): DioError = ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في التعديل: ${e.message}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
