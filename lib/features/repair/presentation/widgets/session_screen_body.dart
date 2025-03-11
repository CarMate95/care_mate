import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_session_appbar.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_session_item.dart';
import 'package:flutter/material.dart';

class SessionScreenBody extends StatelessWidget {
  const SessionScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomSessionAppbar(),
              verticalSpace(32),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => verticalSpace(10),
                itemBuilder: (context, index) => const CustomSessionItem(),
                itemCount: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
