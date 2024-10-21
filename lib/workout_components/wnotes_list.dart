import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'workout_notes.dart';

class WNotesList extends StatefulWidget {
  final Box notesList;
  const WNotesList({super.key, required this.notesList});

  @override
  State<WNotesList> createState() => WNotesListState();
}

class WNotesListState extends State<WNotesList> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Notes', style: TextStyle(fontSize: 20)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return WorkoutNotesClass(index: -1, notesList: widget.notesList,); //Index need to be dynamic
                  }
                );
              }, 
              child: const Text('Add Note'))
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: widget.notesList.length,
            itemBuilder: (context, index) {
              var box = widget.notesList.getAt(index);
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return WorkoutNotesClass(index: index, notesList: widget.notesList,);
                    }
                  );
                },
                child: ListTile(
                  title: Text('${box.name}'),
                  subtitle: Text('${box.note}'),
                )
              );
            }
            
          )
        ),
      ],
    );
  }
}