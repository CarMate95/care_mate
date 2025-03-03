import 'package:car_mate/config/themes/color_manager.dart';
import 'package:car_mate/core/utils/extensions/theme_extension.dart';
import 'package:car_mate/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                        // showScaffoldMessage(context, message: 'Coming soon');
                        chatCubit.pickImage(context);
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
                      children: [
                        CustomTextFormField(
                          hintText: 'Type a message...',
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
                        Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
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
