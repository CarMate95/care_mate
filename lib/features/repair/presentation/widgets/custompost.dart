import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/helpers/time_formate.dart' as timeformate;
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/get_all_posts_model.dart';
import 'package:car_mate/features/repair/presentation/views/request_details_screen.dart';
import 'package:flutter/material.dart';

class CustomPost extends StatelessWidget {
  final GetAllPostsModel post;

  const CustomPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final String currentUserProfilePhotoUrl = post.author.profilePhoto.first;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Container(
        width: double.infinity,
        color:
            context.isDarkMode ? ColorManager.darkGrey : ColorManager.lightGrey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RequestDetailsScreen(
                    postId: post.id,
                    isCompleted: post.isCompleted,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: currentUserProfilePhotoUrl != null
                          ? NetworkImage(currentUserProfilePhotoUrl)
                          : null,
                      child: currentUserProfilePhotoUrl == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    horizontalSpace(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text:
                                  '${post.author.firstName} ${post.author.lastName}',
                              style: getMediumStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            horizontalSpace(5),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xff00AAFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            horizontalSpace(5),
                            CustomText(
                              text: timeformate.timeAgo(post.createdAt),
                              style: getLightStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        CustomText(
                          text:
                              '@${post.author.firstName}${post.author.lastName}',
                          style: getLightStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpace(5),
                const FractionallySizedBox(
                  widthFactor: 0.3,
                  child: CustomDivider(color: ColorManager.black, thickness: 2),
                ),
                CustomText(
                  lines: 5,
                  style: getLightStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                  text: post.postContent,
                ),
                if (post.images != null && post.images!.isNotEmpty)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: post.images!.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        post.images![index],
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
        ),
      ),
    );
  }
}
