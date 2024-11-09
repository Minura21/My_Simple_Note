import 'package:flutter/material.dart';
import 'package:notepadapp/models/note_model.dart';
//import 'package:notepadapp/db_helper/sql_helper.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _saveNote() {
    if (titleController.text.isEmpty || bodyController.text.isEmpty) {
      return;
    }
    final note = Note(
      description: bodyController.text,
      title: titleController.text,
    );
    Navigator.of(context).pop(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Create Note',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              maxLines: null,
              cursorColor: Colors.blue,
              controller: titleController,
              style: const TextStyle(fontSize: 28),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Title"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: null,
              controller: bodyController,
              cursorColor: Colors.blue,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write something here",
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveNote,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
