import 'package:car_mate/config/routes/page_name.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/helpers/time_formate.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_divider.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/core/utils/widgets/custom_text.dart';
import 'package:car_mate/features/repair/data/models/get_specific_post_model.dart';
import 'package:car_mate/features/repair/data/repo/get_specific_post_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestDetailsBody extends StatelessWidget {
  final int postId;
  const RequestDetailsBody({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    final GetSpecificPostRepository postRepository =
        GetSpecificPostRepository();

    return CustomScaffold(
      body: FutureBuilder<GetSpecificPostModel>(
        future: postRepository.getPostById(postId),
        builder: (context, postSnapshot) {
          if (postSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (postSnapshot.hasError) {
            return Center(
                child: Text('Failed to load post: ${postSnapshot.error}'));
          } else if (!postSnapshot.hasData) {
            return const Center(child: Text('Post not found'));
          }

          final post = postSnapshot.data!;
          final author = post.user;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                CustomAppBar(
                  enbleBackIcon: true,
                  title: CustomText(text: TextManager.requests.tr()),
                ),
                verticalSpace(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: author.profilePhoto.isNotEmpty
                              ? NetworkImage(author.profilePhoto.first)
                              : null,
                          child: author.profilePhoto.isEmpty
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
                                      '${author.firstName} ${author.lastName}',
                                  style: getMediumStyle(
                                      color: context.secondaryColor),
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
                                  text: timeAgo(post.createdAt),
                                  style: getLightStyle(
                                          color: context.secondaryColor)
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            CustomText(
                              text: '@${author.firstName}',
                              style: getLightStyle(),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, PageName.getOffersScreen,
                                arguments: postId);
                          },
                          icon: Icon(
                            size: 28,
                            Icons.supervised_user_circle,
                            color: context.secondaryColor,
                          ),
                        )
                      ],
                    ),
                    verticalSpace(5),
                    const FractionallySizedBox(
                      widthFactor: 0.3,
                      child: CustomDivider(thickness: 2),
                    ),
                    CustomText(
                      text: post.postContent,
                      style:
                          getLightStyle().copyWith(fontWeight: FontWeight.w700),
                    ),
                    verticalSpace(10),
                    if (post.images != null)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: post.images!.length,
                          itemBuilder: (context, index) {
                            return Image.network(post.images![index]);
                          },
                        ),
                      ),
                    // if (userRole == UserRole.worker)
                    //   CustomOfferHelp(
                    //     onTap: () {
                    //       showAlertDialogToMechanic(
                    //           context,
                    //           postId,
                    //           post.userId,
                    //           author.firstName + ' ' + author.lastName);
                    //     },
                    //   ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
