import 'package:car_mate/features/repair/presentation/pages/requests_screen.dart';
import 'package:car_mate/features/chat/presentation/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/widgets/custom_scaffold.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../my_car/presentation/pages/my_car_screen.dart';
import '../cubit/layout_cubit.dart';
import '../widgets/custom_layout_button_nav_bar.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(screens: [
        const HomeScreen(), // Home Screen
        const RequestsScreen(), // Repair Screen
        const MyCarScreen(), // My Car Screen
        const ChatScreen(), // Chat with AI Screen
      ]),
      child: Builder(builder: (context) {
        return BlocBuilder<LayoutCubit, LayoutState>(
          builder: (context, state) {
            var layoutCubit = LayoutCubit.get(context);
            return CustomScaffold(
              body: layoutCubit.screens[layoutCubit.currentIndex],
              bottomNavigationBar: const CustomLayoutButtonNavBar(),
            );
          },
        );
      }),
    );
  }
}
