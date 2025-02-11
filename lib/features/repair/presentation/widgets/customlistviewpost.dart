import 'package:car_mate/features/repair/presentation/widgets/custompost.dart';
import 'package:flutter/material.dart';

class CustomListViewPosts extends StatelessWidget {
  const CustomListViewPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => const CustomPost(),
        itemCount: 20,
      ),
    );
  }
}
