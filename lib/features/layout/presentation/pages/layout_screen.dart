import 'package:car_mate/features/my_car/pages/upload_licence_screen.dart';
import 'package:car_mate/features/repair/presentation/views/requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../../../chat/presentation/pages/intro_ai_screen.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../profile/profile_cubit/profile_cubit.dart';
import '../cubit/layout_cubit.dart';
import '../widgets/custom_layout_button_nav_bar.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit(screens: [
            const HomeScreen(), // Home Screen
            const RequestsScreen(), // Repair Screen
            const UploadLicenceScreen(), // My Car Screen
            const IntroAiScreen(),

            // Chat with AI Screen
          ]),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            var layoutCubit = LayoutCubit.get(context);
            return CustomScaffold(
              horizontalPadding: 0,
              body: layoutCubit.screens[layoutCubit.currentIndex],
              bottomNavigationBar: const CustomLayoutButtonNavBar(),
            );
          },
        );
      }),
    );
  }
}
