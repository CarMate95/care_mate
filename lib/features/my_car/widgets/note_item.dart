import 'package:car_mate/features/my_car/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note.title),
      subtitle: Text(note.description),
      trailing: Text(
        '${note.date.day}/${note.date.month}/${note.date.year}',
      ),
    );
  }
}
