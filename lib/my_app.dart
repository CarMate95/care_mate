import 'package:car_mate/config/theme_cubit/theme_cubit_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/routes/page_name.dart';
import 'config/routes/route_manager.dart';
import 'config/themes/themes.dart';
import 'features/profile/profile_cubit/profile_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    RouteManager.ctx = context;
    return ScreenUtilInit(
      designSize: const Size(370, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit.get(context),
          ),
        ],
        child: Builder(builder: (context) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: ThemeCubit.themeMode,
                navigatorKey: RouteManager.navigatorKey,
                initialRoute: PageName.splashScreen,
                onGenerateRoute: RouteManager.onGenerateRoute,
              );
            },
          );
        }),
      ),
    );
  }
}
