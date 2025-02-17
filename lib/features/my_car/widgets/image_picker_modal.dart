import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModal extends StatelessWidget {
  final Function(String) onImagePicked;

  const ImagePickerModal({super.key, required this.onImagePicked});

  void _pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      onImagePicked(pickedFile.path);
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: () => _pickImage(ImageSource.camera, context),
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Gallery'),
          onTap: () => _pickImage(ImageSource.gallery, context),
        ),
      ],
    );
  }
}
