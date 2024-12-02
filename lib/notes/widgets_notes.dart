import 'package:flutter/material.dart';

import 'note_model.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: ListTile(
        title: Text(
          note.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: note.content?.isNotEmpty == true
            ? Text(
                note.content!,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              )
            : null,
      ),
    );
  }
}
