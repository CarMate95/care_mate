import 'package:car_mate/config/themes/assets_manager.dart';
import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/features/alerts/presentation/pages/alerts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/svg.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;

  List<Widget> screens = [
    Container(),
    Container(),
    Container(),
    Container(),
    const AlertsScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? ColorManager.darkGrey : ColorManager.white,
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
        color: context.isDarkMode ? ColorManager.darkGrey : ColorManager.white,
        margin: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 35.sp),
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
                      "Home",
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
                      "Repair",
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
                      "Car",
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
                      "robot",
                      SvgPicture.asset(
                        AssetsManager.robotIcon,
                        color: context.isDarkMode
                            ? ColorManager.white
                            : ColorManager.black,
                      ),
                    )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsManager.alertIconBottom,
                      color: context.isDarkMode
                          ? ColorManager.white
                          : ColorManager.black,
                    ),
                    label: '',
                    activeIcon: activeIcon(
                      context,
                      "Alerts",
                      SvgPicture.asset(
                        AssetsManager.alertIconBottom,
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
      padding: EdgeInsets.all(2.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.sp),
        child: Container(
          padding: EdgeInsets.all(2.sp),
          height: 30.h,
          color: ColorManager.black,
          child: Row(children: [
            icon,
            horizontalSpace(1.sp),
            Text(title,
                style: getBoldStyle(
                    color: context.isDarkMode
                        ? ColorManager.white
                        : ColorManager.black,
                    fontSize: 9.sp))
          ]),
        ),
      ),
    );
  }
}
