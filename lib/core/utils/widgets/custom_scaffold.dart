import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.floatingActionButton,
    this.horizontalPadding,
  });
  final AppBar? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final double? horizontalPadding;
  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16.w),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
