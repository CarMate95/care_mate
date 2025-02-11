import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const SettingsOption({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: context.secondaryColor,),
      title: Text(title),
      onTap: onTap,
    );
  }
}
