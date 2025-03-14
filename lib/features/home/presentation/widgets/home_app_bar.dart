import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_mate/features/auth/domain/entities/user_entity.dart';
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

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        UserEntity? userEntity = ProfileCubit.get().userEntity;
        return Skeletonizer(
          enabled: state is ProfileLoading,
          child: Row(
            children: [
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, PageName.accountdetailsScreen),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: SizedBox(
                    height: 50.h,
                    width: 50.w,
                    child: userEntity == null
                        ? Image.asset("assets/images/profile_image.jpg")
                        : CachedNetworkImage(
                            imageUrl: userEntity.profileImage!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, PageName.accountdetailsScreen),
                    child: Text(
                      userEntity?.firstName ?? "Null",
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
          ),
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
