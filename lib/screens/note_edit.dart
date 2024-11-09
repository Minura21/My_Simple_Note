import 'package:flutter/material.dart';
import 'package:notepadapp/db_helper/sql_helper.dart';
import 'package:notepadapp/models/note_model.dart';

class NoteEdit extends StatelessWidget {
  const NoteEdit({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: note.title);
    final TextEditingController bodyController =
        TextEditingController(text: note.description);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Edit Note",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              cursorColor: Colors.blue,
              maxLines: null,
              controller: titleController,
              style: const TextStyle(
                fontSize: 26,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: Colors.blue,
              controller: bodyController,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                hintText: "Write something here",
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)),
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (titleController.text.isEmpty || bodyController.text.isEmpty) {
            return;
          }
          final updatedNote = Note(
            id: note.id,
            title: titleController.text,
            description: bodyController.text,
          );

          // Update note in the SQLite database
          await DatabaseHelper.instance.updateNote(updatedNote);

          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
