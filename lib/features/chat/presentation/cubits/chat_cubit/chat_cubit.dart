import 'dart:typed_data';

import 'package:car_mate/core/utils/functions/kprint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/services/image_picker_service.dart';
import '../../../../../core/utils/widgets/custom_scaffold_message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(BuildContext context) =>
      BlocProvider.of<ChatCubit>(context);

  late final GenerativeModel _model;
  late final ChatSession chat;
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> generatedContent =
      <({Image? image, String? text, bool fromUser})>[];

  Image? image;
  String? text;
  Uint8List? imageBytes;

  initChat() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyCj501NME-K9xFjOZyRFM0JmrFjjeUeJEI',
    );
    chat = _model.startChat();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  // handle send general message to send text and image
  Future<void> sendGeneralMessage(BuildContext context) async {
    if (textController.text.isEmpty && this.image == null) {
      showScaffoldMessage(context, message: "Can't send empty message");
      return;
    }
    text = textController.text;
    textController.clear();
    Uint8List? imageBytes = this.imageBytes;
    Image? image = this.image;
    // this.imageBytes = null;
    // Image? image = this.image;
    // this.image = null;
    generatedContent.add((image: image, text: text, fromUser: true));

    this.image = null;
    this.imageBytes = null;

    emit(ChatLoading());
    try {
      if (imageBytes == null) {
        final response = await chat.sendMessage(
          Content.text(text!),
        );
        final aiText = response.text;
        generatedContent.add((image: null, text: aiText, fromUser: false));
        emit(ChatSuccess());
        scrollDown();
        return;
      } else {
        kprint(imageBytes.length.toString());
        final response = await chat.sendMessage(
          Content.multi(
            [
              TextPart(text!), // text
              DataPart('image/jpeg', imageBytes), // image
            ],
          ),
        );
        final aiText = response.text;
        generatedContent.add((image: null, text: aiText, fromUser: false));

        emit(ChatSuccess());
        scrollDown();
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showError(context, message: e.toString());
      emit(ChatError(message: e.toString()));
    }
  }

  Future<void> pickImage(BuildContext context,
      {ImageSource source = ImageSource.gallery}) async {
    final XFile? pickedFile = source == ImageSource.camera
        ? await ImagePickerService.pickFromCamera()
        : await ImagePickerService.pickFromGallery();
    if (pickedFile == null) return;

    imageBytes = await pickedFile.readAsBytes();
    image = Image.memory(imageBytes!);

    emit(ImagePicked());
  }

  void showError(BuildContext context, {required String message}) {
    kprint(message);
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  void dispose() {
    scrollController.dispose();
    textController.dispose();
    textFieldFocus.dispose();
  }
}
