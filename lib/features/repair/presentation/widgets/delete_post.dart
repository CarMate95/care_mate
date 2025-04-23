import 'dart:ui';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/repair/data/repo/post_repo.dart';
import 'package:car_mate/features/repair/presentation/views/own_posts_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeletePost extends StatelessWidget {
  final int postId;
  final postRepository = PostRepository();

  DeletePost({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: context.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: context.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: context.secondaryColor, width: 3),
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: ColorManager.primaryColor,
                  size: 50,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                TextManager.areYouSure.tr(),
                style: getBoldStyle(
                  fontSize: 20,
                  color: context.secondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                TextManager.deletePost.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: context.secondaryColor,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await postRepository.deletePost(postId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            TextManager.deletePost.tr(),
                            style: getBoldStyle(color: ColorManager.white),
                          ),
                          duration: const Duration(seconds: 3),
                          backgroundColor: ColorManager.primaryColor,
                        ),
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OwnPostsScreen()));
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "❌ فشل حذف المنشور، يرجى المحاولة لاحقًا",
                            style: getBoldStyle(color: ColorManager.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    TextManager.deletePost.tr(),
                    style: getBoldStyle(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
