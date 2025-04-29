import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/text_manager.dart';
import '../cubit/chat_cubit.dart';
import 'ai_text_field.dart';
import 'main_app_bar.dart';
import 'message_widget.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({
    super.key,
  });

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  void initState() {
    super.initState();

    ChatCubit.get(context).initChat();
  }

  @override
  Widget build(BuildContext context) {
    var chatCubit = ChatCubit.get(context);

    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // custom app bar
              const MainAppBar(
                isChatbotScreen: true,
              ),

              Expanded(
                  child: ListView.builder(
                controller: chatCubit.scrollController,
                itemBuilder: (context, index) {
                  final content = chatCubit.generatedContent[index];
                  return MessageWidget(
                    text: content.text,
                    image: content.image,
                    isFromUser: content.fromUser,
                  );
                },
                itemCount: chatCubit.generatedContent.length,
              )),
              if (state is ChatLoading) ...{
                MessageWidget(
                  text: TextManager.aiTyping.tr(),
                  image: null,
                  isFromUser: false,
                ),
              },
              // bottom text field and actions
              const AiTextField(),
            ],
          ),
        );
      },
    );
  }
}
