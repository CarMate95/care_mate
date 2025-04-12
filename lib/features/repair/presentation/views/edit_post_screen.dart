import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_floating_action_button.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/auth/data/repositories/user_repo.dart';
import 'package:car_mate/features/repair/data/models/post_model.dart';
import 'package:car_mate/features/repair/data/repo/post_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../auth/domain/entities/user_entity.dart';
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
  final UserRepository userRepository = UserRepository();
  bool isTextEntered = false;
  List<String> selectedImages = [];
  UserEntity? currentUser;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController(text: widget.post.postContent);
    selectedImages = List.from(widget.post.images);
    contentController.addListener(() {
      setState(() {
        isTextEntered = contentController.text.isNotEmpty;
      });
    });
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = ProfileCubit.get(context).userEntity;
      setState(() {
        currentUser = user;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    setState(() {
      selectedImages.addAll(images.map((e) => e.path));
    });
  }

  Future<void> _submitPost() async {
    if (isTextEntered && currentUser != null) {
      final updatedPost = widget.post.copyWith(
        postContent: contentController.text,
        images: selectedImages,
        updatedAt: DateTime.now(),
      );

      try {
        await postRepository.editPost(
          widget.post.id,
          updatedPost.postContent,
          selectedImages,
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
          backgroundColor: ColorManager.darkGrey),
      body: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: ListView(
          children: [
            Row(
              children: [
                // CustomCircularAvatar(
                //   image: widget.post.images.first,
                // ),
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
            if (widget.post.images.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.post.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.post.images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  );
                },
              )
            else
              CustomText(
                text: '',
                style: getLightStyle().copyWith(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
