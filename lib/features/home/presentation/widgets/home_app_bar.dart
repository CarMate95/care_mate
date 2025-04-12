import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_mate/features/auth/data/models/user_data.dart';
import 'package:car_mate/features/profile/profile_cubit/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../config/routes/page_name.dart';
import '../../../../config/themes/assets_manager.dart';
import '../../../../config/themes/color_manager.dart';
import '../../../../config/themes/text_manager.dart';
import '../../../../config/themes/text_style.dart';
import '../../../../core/utils/functions/spacing.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        UserData? userData = ProfileCubit.get(context).userModel?.userData;
        return Row(
          children: [
            Skeletonizer(
              enabled: state is ProfileLoading,
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, PageName.accountdetailsScreen),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: userData == null
                        ? Image.asset("assets/images/profile_image.jpg")
                        : CachedNetworkImage(
                            imageUrl: userData.profileImage!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Skeletonizer(
              enabled: state is ProfileLoading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, PageName.accountdetailsScreen),
                    child: Text(
                      userData?.firstName ?? "Null",
                      style: getBoldStyle(fontSize: 16.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  verticalSpace(2.sp),
                  Text(
                    TextManager.welcomeBack.tr(),
                    style: getBoldStyle(fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                _iconButton(
                  context,
                  icon: SvgPicture.asset(AssetsManager.notificationIcon),
                  onTap: () => Navigator.pushNamed(
                    context,
                    PageName.notificationScreen,
                  ),
                ),
                horizontalSpace(8.sp),
                _iconButton(
                  context,
                  icon: Image.asset(AssetsManager.settingPicturePng),
                  onTap: () =>
                      Navigator.pushNamed(context, PageName.settingsScreen),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Widget _iconButton(BuildContext context,
    {required Widget icon, required VoidCallback onTap}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8.r),
    child: Container(
      height: 40.h,
      width: 40.w,
      color: ColorManager.lightGrey,
      child: GestureDetector(
        onTap: onTap,
        child: icon,
      ),
    ),
  );
}
