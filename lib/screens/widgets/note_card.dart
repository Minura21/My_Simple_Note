import 'package:flutter/material.dart';
import 'package:notepadapp/models/note_model.dart';
import 'package:notepadapp/screens/note_view.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onNoteDeleted,
    required this.index,
  });

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NoteView(
              note: note,
              index: index,
              onNoteDeleted: onNoteDeleted,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title.isNotEmpty ? note.title : "Untitled",
                style: const TextStyle(fontSize: 18),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                note.description.isNotEmpty ? note.description : "No content",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
