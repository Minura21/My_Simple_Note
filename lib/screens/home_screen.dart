import 'package:flutter/material.dart';
import 'package:notepadapp/db_helper/sql_helper.dart';
import 'package:notepadapp/models/note_model.dart';
import 'package:notepadapp/screens/create_note.dart';
import 'package:notepadapp/screens/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes(); // Load notes from database when the screen initializes
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await DatabaseHelper.instance.getNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: notes.isEmpty
          ? const Center(child: Text("No notes available"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteCard(
                  note: notes[index],
                  index: index,
                  onNoteDeleted: onNoteDeleted,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNote(
                onNewNoteCreated: onNewNoteCreated,
              ),
            ),
          );
          if (newNote != null) onNewNoteCreated(newNote);
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void onNewNoteCreated(Note note) async {
    await DatabaseHelper.instance.insertNote(note);
    _loadNotes();
  }

  void onNoteDeleted(int index) async {
    final noteToDelete = notes[index];
    await DatabaseHelper.instance.deleteNote(noteToDelete.id!);
    _loadNotes();
  }
}
