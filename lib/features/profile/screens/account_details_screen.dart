import 'dart:io';

import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/config/themes/text_style.dart';
import 'package:car_mate/core/utils/functions/spacing.dart';
import 'package:car_mate/core/utils/widgets/custom_app_bar.dart';
import 'package:car_mate/core/utils/widgets/custom_scaffold.dart';
import 'package:car_mate/features/profile/widgets/profile_service.dart';
import 'package:car_mate/features/repair/presentation/widgets/custom_image_profile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  _AccountDetailsScreenState createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  late Future<Map<String, dynamic>?> userProfile;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? _image;
  Map<String, dynamic>? currentUser;

  @override
  void initState() {
    super.initState();
    userProfile = ProfileService.getProfile();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void updateProfile() async {
    if (currentUser == null) return;

    Map<String, dynamic> currentData = {
      "firstName": currentUser!['firstName'],
      "lastName": currentUser!['lastName'],
      "email": currentUser!['email'],
      "phone": currentUser!['phone'],
    };

    final response = await ProfileService.updateProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      profilePhoto: _image,
      currentData: currentData,
    );

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TextManager.update.tr())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TextManager.noupdate.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: FutureBuilder<Map<String, dynamic>?>(
            future: userProfile,
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const Center(child: CircularProgressIndicator());
              // } else if (snapshot.hasError || snapshot.data == null) {
              //   return const Center(child: Text('فشل تحميل البيانات'));
              // }
              if (snapshot.hasData) {
                currentUser = snapshot.data!;
                firstNameController.text = currentUser!['firstName'];
                lastNameController.text = currentUser!['lastName'];
                emailController.text = currentUser!['email'];
                phoneController.text = currentUser?['phone'] ?? '';
              }

              return Skeletonizer(
                enabled: snapshot.connectionState == ConnectionState.waiting,
                child: Column(
                  children: [
                    CustomAppBar(
                      title: Text(TextManager.accountDetails.tr()),
                    ),
                    verticalSpace(20),
                    GestureDetector(
                      onTap: pickImage,
                      child: CustomImageProfile(
                        imageIcon: 'assets/svg/Edit.svg',
                        alignment: Alignment.bottomRight,
                        imageUrl: _image != null
                            ? _image!.path
                            : currentUser?['profilePhoto'][0],
                      ),
                    ),
                    verticalSpace(20),
                    TextField(
                      controller: firstNameController,
                      decoration: inputDecoration(TextManager.firstName.tr()),
                    ),
                    verticalSpace(16),
                    TextField(
                      controller: lastNameController,
                      decoration: inputDecoration(TextManager.lastName.tr()),
                    ),
                    verticalSpace(16),
                    TextField(
                      controller: emailController,
                      decoration: inputDecoration(TextManager.email.tr()),
                    ),
                    verticalSpace(16),
                    TextField(
                      controller: phoneController,
                      decoration: inputDecoration(TextManager.phone.tr()),
                    ),
                    verticalSpace(30),
                    ElevatedButton(
                      onPressed: updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                      ),
                      child: Text(
                        TextManager.updatedata.tr(),
                        style: getBoldStyle(
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
