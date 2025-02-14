import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/features/home/presentation/pages/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      //FirebaseAuth.instance.currentUser!.emailVerified?screens[currentIndex]:Container(
      //         width: double.infinity,
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: 40),
      //           child: ElevatedButton(
      //               style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFFF8B145)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius:BorderRadius.circular(4))
      //               )),
      //               onPressed: ()
      //               async {
      //
      //                 FirebaseAuth.instance.currentUser!.sendEmailVerification();
      //                 Navigator.of(context).pushNamedAndRemoveUntil(login, (route) => false);
      //
      //               }, child:Text
      //             ('verify your email',style: TextStyle(color: Colors.white),)),
      //         ),
      //       ),
      body: screens[currentIndex],

      bottomNavigationBar: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 4.sp),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.sp),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsManager.homeIcon,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                    label: '',
                    activeIcon: activeIcon(
                      context,
                      TextManager.home.tr(),
                      SvgPicture.asset(
                        AssetsManager.homeIcon,
                        color: context.isDarkMode
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsManager.repairIcon,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                    label: '',
                    activeIcon: activeIcon(
                      context,
                      TextManager.repair.tr(),
                      SvgPicture.asset(
                        AssetsManager.repairIcon,
                        color: context.isDarkMode
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsManager.carIcon,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                    label: '',
                    activeIcon: activeIcon(
                      context,
                      TextManager.myCar.tr(),
                      SvgPicture.asset(
                        AssetsManager.carIcon,
                        color: context.isDarkMode
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsManager.robotIcon,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                    label: '',
                    activeIcon: activeIcon(
                      context,
                      TextManager.aiChat.tr(),
                      SvgPicture.asset(
                        AssetsManager.robotIcon,
                        color: context.isDarkMode
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    )),
              ]),
        ),
      ),
    );
  }

  Padding activeIcon(BuildContext context, String title, Widget icon) {
    return Padding(
      padding: EdgeInsets.only(left: 5.sp, right: 3.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.sp),
        child: Container(
          padding: EdgeInsets.all(2.sp),
          height: 40.h,
          color: context.isDarkMode ? ColorManager.black : ColorManager.white,
          child: Row(children: [
            icon,
            horizontalSpace(2.sp),
            Text(title,
                style: getBoldStyle(
                    color: context.isDarkMode
                        ? ColorManager.white
                        : ColorManager.black,
                    fontSize: context.locale.languageCode == 'en_US'
                        ? 12.sp
                        : 11.sp)),
          ]),
        ),
      ),
    );
  }
}
