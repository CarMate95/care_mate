import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/home/presentation/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScaffold(
        // appBar: homeAppbar(context),
        body: HomeBody(),
      ),
    );
  }
}
