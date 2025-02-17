import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/alerts/presentation/pages/alerts_screen.dart';
import 'package:car_mate/features/my_car/pages/add_note_page.dart';
import 'package:car_mate/features/notifications/presentation/pages/notification_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/logout_button.dart';
import 'account_details_screen.dart';
import '../widgets/delete_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: context.scaffoldBackgroundColor,
        title: Text(TextManager.settings.tr()),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.tertiaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const ProfileHeader(),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.tertiaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                SettingsOption(
                  icon: Icons.account_circle,
                  title: TextManager.accountDetails.tr(),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: context.secondaryColor),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountDetailsScreen()),
                  ),
                ),
                const Divider(color: Colors.grey),
                SettingsOption(
                  icon: Icons.notifications,
                  title: TextManager.notification.tr(),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: context.secondaryColor),
                      onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  ),
                ),
                const Divider(color: Colors.grey),
                SettingsOption(
                  icon: Icons.share,
                  title: TextManager.shareApp.tr(),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: context.secondaryColor),
                      onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AlertsScreen()),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.tertiaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                SettingsOption(
                  icon: Icons.color_lens,
                  title: TextManager.appearance.tr(),
                  trailing: Switch(
                    activeColor: context.tertiaryColor,
                    value: false,
                    onChanged: (value) {
                      context.changeTheme();
                    },
                  ),
                ),
                const Divider(color: Colors.grey),
                SettingsOption(
                  icon: Icons.language,
                  title: TextManager.language.tr(),
                  trailing: Switch(
                    activeColor: context.tertiaryColor,
                    value: false,
                    onChanged: (value) {
                      context.changeLanguage();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: context.tertiaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const LogoutButton(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  TextManager.deleteWarning.tr(),
                  textAlign: TextAlign.center,
                  style:
                      getBoldStyle(fontSize: 16, color: context.secondaryColor),
                ),
                const DeleteButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsOption({
    super.key,
    required this.icon,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: context.secondaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: context.secondaryColor,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
