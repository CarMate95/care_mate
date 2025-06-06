import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/auth/data/models/user_data.dart';
import 'package:car_mate/features/profile/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        UserData? userData = ProfileCubit.get(context).userModel?.userData;
        return Skeletonizer(
          enabled: state is ProfileLoading,
          child: Row(
            children: [
              if (userData == null) ...{
                const CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('assets/svg/gmail_icon_svg.jpg')),
              } else ...{
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      CachedNetworkImageProvider(userData.profileImage!),
                ),
              },
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${userData?.firstName} ${userData?.lastName}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(userData?.email ?? '',
                      style: TextStyle(
                          color: context.secondaryColor, fontSize: 12.sp)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
