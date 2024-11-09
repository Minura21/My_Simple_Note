import 'package:flutter/material.dart';
import 'package:notepadapp/db_helper/sql_helper.dart';
import 'package:notepadapp/models/note_model.dart';
import 'package:notepadapp/screens/note_edit.dart';

class NoteView extends StatelessWidget {
  const NoteView(
      {super.key,
      required this.note,
      required this.index,
      required this.onNoteDeleted});

  final Note note;
  final int index;
  final Function(int) onNoteDeleted;

  Future<void> _deleteNote() async {
    await DatabaseHelper.instance.deleteNote(note.id!);
    onNoteDeleted(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Note View",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Delete This?",
                      style: TextStyle(fontSize: 22),
                    ),
                    content: Text("Note '${note.title}' will be deleted!"),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _deleteNote(); // Delete note from SQLite
                          Navigator.of(context)
                              .pop(); // Go back to previous screen
                        },
                        child: const Text(
                          "DELETE",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              note.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEdit(
                note: note,
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
