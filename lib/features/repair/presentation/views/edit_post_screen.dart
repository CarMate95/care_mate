import 'dart:io';

import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_floating_action_button.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/post_model.dart';
import 'package:car_mate/features/repair/data/repo/post_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/data/models/user_data.dart';
import '../../../profile/profile_cubit/profile_cubit.dart';

class EditPostScreen extends StatefulWidget {
  final PostModel post;

  const EditPostScreen({super.key, required this.post});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController contentController;
  final PostRepository postRepository = PostRepository();
  bool isTextEntered = false;

  List<String> existingImages = []; // الصور القديمة
  List<String> newImages = []; // الصور الجديدة
  UserData? currentUser;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.post.postContent);
    existingImages = List.from(widget.post.images);

    contentController.addListener(() {
      setState(() {
        isTextEntered = contentController.text.isNotEmpty;
      });
    });

    final user = ProfileCubit.get(context).userModel?.userData;
    if (user != null) {
      currentUser = user;
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    setState(() {
      newImages.addAll(images.map((e) => e.path));
    });
  }

  Future<void> _submitPost() async {
    if (isTextEntered && currentUser != null) {
      final updatedPost = widget.post.copyWith(
        postContent: contentController.text,
        images: [...existingImages, ...newImages],
        updatedAt: DateTime.now(),
      );

      try {
        await postRepository.editPost(
          widget.post.id,
          updatedPost.postContent,
          [...existingImages, ...newImages],
          currentUser!.id!,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post Updated Successfully')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update post: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: mediaQuery.height * 0.1,
        backgroundColor: ColorManager.darkGrey,
        title: CustomText(
            text: TextManager.editPost.tr(),
            style: getBoldStyle(color: ColorManager.lightGrey)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: ColorManager.lightGrey,
              size: 30,
            )),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: _pickImages,
        icon: Icons.photo_library_rounded,
        backgroundColor: ColorManager.darkGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: ListView(
          children: [
            Row(
              children: [
                horizontalSpace(5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: currentUser != null
                          ? '${currentUser!.firstName} ${currentUser!.lastName}'
                          : 'Loading...',
                      style: getMediumStyle(color: context.secondaryColor)
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    CustomText(
                      text: '@${currentUser?.firstName ?? 'Loading...'}',
                      style: getLightStyle(color: context.secondaryColor)
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: _submitPost,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isTextEntered
                          ? ColorManager.lightGrey
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorManager.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 5.0.h),
                      child: CustomText(
                        text: TextManager.post,
                        style: getMediumStyle(
                            color: isTextEntered
                                ? ColorManager.black
                                : ColorManager.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const CustomDivider(),
            TextField(
              controller: contentController,
              maxLines: null,
              cursorColor:
                  context.isDarkMode ? ColorManager.grey : ColorManager.black,
              style: getLightStyle(color: context.secondaryColor),
              decoration: InputDecoration(
                labelStyle: getMediumStyle(),
                hintText: TextManager.whatHappening.tr(),
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),

            // صور قديمة
            if (existingImages.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: existingImages.asMap().entries.map((entry) {
                  final index = entry.key;
                  final url = entry.value;
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              existingImages.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),

            // صور جديدة
            if (newImages.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: newImages.asMap().entries.map((entry) {
                  final index = entry.key;
                  final path = entry.value;
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              newImages.removeAt(index);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
