import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/config/themes/text_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/core/utils/widgets/custom_alert_dialog.dart';
import 'package:car_mate/features/chat/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/widgets/custom_text_form_field.dart';

class AiTextField extends StatelessWidget {
  const AiTextField({super.key});

  @override
  Widget build(BuildContext context) {
    var chatCubit = ChatCubit.get(context);
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // picked image preview
              if (chatCubit.imageBytes != null) ...{
                Container(
                  height: 60.h,
                  width: 70.w,
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: context.primaryColor,
                    border: Border.all(
                      color: context.secondaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: MemoryImage(chatCubit.imageBytes!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              },
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: context.tertiaryColor,
                    radius: 24.r,
                    child: IconButton(
                      onPressed: () {
                        // choos image from gallery of camera
                        showCustomAlertDialog(
                          context: context,
                          title: TextManager.pickAnImage.tr(),
                          content: Column(children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: Text(TextManager.camera.tr()),
                              onTap: () async {
                                await chatCubit.pickImage(
                                  context,
                                  source: ImageSource.camera,
                                );
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: Text(TextManager.gallery.tr()),
                              onTap: () async {
                                await chatCubit.pickImage(context);
                                Navigator.pop(context);
                              },
                            ),
                          ]),
                        );
                        // chatCubit.pickImage(context);
                      },
                      icon: Icon(
                        Icons.image,
                        size: 24.r,
                        color: context.secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 8),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        CustomTextFormField(
                          hintText: TextManager.askAI.tr(),
                          verticalPadding: 7.h,
                          borderRadius: 44,
                          borderColor: ColorManager.grey,
                          autofocus: true,
                          focusNode: chatCubit.textFieldFocus,
                          controller: chatCubit.textController,
                          onFieldSubmitted: (message) async {
                            if (message.isEmpty) {
                              return;
                            }
                            chatCubit.sendGeneralMessage(context);
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.secondaryColor,
                                width: 1,
                              )),
                          child: IconButton(
                            onPressed: () async {
                              chatCubit.sendGeneralMessage(context);
                            },
                            icon: Icon(
                              Icons.send,
                              size: 24.r,
                              color: ColorManager.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
