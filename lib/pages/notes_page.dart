import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/component/my_drawer.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  @override
  void initState() {
    super.initState();
    readNotes();
  }
  //text controller
  final textController = TextEditingController();
  // create a note
  void createNote(){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(onPressed: (){
            context.read<NoteDatabase>().addNote(textController.text);
            textController.clear();
            Navigator.pop(context);
          },child: const Text('Create'),)
        ],
    ));
  }
  //read notes
  void readNotes(){
    context.read<NoteDatabase>().fetchNotes();
  }
  //update notes
  void updateNote(Note note){
    textController.text = note.text;
    showDialog(context: context, builder: (context)=>
    AlertDialog(
      title: Text('Update Note'),
      content: TextField(
        controller: textController,
      ),
      actions: [
        MaterialButton(onPressed: (){
          context.read<NoteDatabase>().updateNote(note.id, textController.text);
          textController.clear();
          Navigator.pop(context);
        },child: const Text('Update'),),

      ]
    ));
  }
  //delete notes
  void deleteNote(int id){
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {

    final noteDatabase =  context.watch<NoteDatabase>();
    final List<Note> currentNotes = noteDatabase.currentNotes;

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text("Notes", style:GoogleFonts.dmSerifText(fontSize: 48,color: Theme.of(context).colorScheme.inversePrimary),)

          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
                itemBuilder: (context,index){
              final note = currentNotes[index];

              return ListTile(
                title: Text(note.text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()=> updateNote(note), icon: const Icon(Icons.edit)),
                    IconButton(onPressed: () => deleteNote(note.id), icon: const Icon(Icons.delete)),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
