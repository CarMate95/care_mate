import 'dart:io';
import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_floating_action_button.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/auth/data/models/user_model.dart';
import 'package:car_mate/features/auth/data/repositories/user_repo.dart';
import 'package:car_mate/features/repair/data/models/add_post_model.dart';
import 'package:car_mate/features/repair/data/repo/add_post_repo.dart';
import 'package:car_mate/features/repair/presentation/widgets/customcircularavatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController contentController = TextEditingController();
  final AddPostRepository addPostRepository = AddPostRepository();
  final UserRepository userRepository = UserRepository();
  bool isTextEntered = false;
  List<String> selectedImages = [];
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    contentController.addListener(() {
      setState(() {
        isTextEntered = contentController.text.isNotEmpty;
      });
    });
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await userRepository.getUser();
      setState(() {
        currentUser = user;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: $e')),
      );
    }
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  Future<void> _submitPost() async {
    if (isTextEntered && currentUser != null) {
      final newPost = AddPostModel(
        postContent: contentController.text,
        images: selectedImages,
        userId: currentUser!.id,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        userData: UserDataModel(
          firstName: currentUser!.firstName,
          lastName: currentUser!.lastName,
          profilePhoto: [currentUser!.profilePhoto!.first],
        ),
      );

      try {
        await addPostRepository.createPost(
          newPost,
          selectedImages.map((path) => File(path)).toList(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post Created Successfully')),
        );
        contentController.clear();
        setState(() => selectedImages.clear());
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post: $e')),
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
            text: TextManager.requests.tr(),
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
          onPressed: () {},
          icon: Icons.photo_library_rounded,
          backgroundColor: ColorManager.darkGrey),
      body: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: ListView(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(AssetsManager.worker1),
                ),
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
                  onTap: () {
                    _submitPost();
                  },
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
            if (selectedImages.isNotEmpty)
              Wrap(
                spacing: 8.0,
                children: selectedImages
                    .map((image) =>
                        Image.network(image, width: 100, height: 100))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
