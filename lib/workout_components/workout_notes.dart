import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_db.dart';

class WorkoutNotes extends StatefulWidget {
  const WorkoutNotes({super.key});

  @override
  State<WorkoutNotes> createState() => _WorkoutNotesState();
}

class _WorkoutNotesState extends State<WorkoutNotes> {

  final TextEditingController _notesField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return IntrinsicHeight(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Notes', style: TextStyle(fontSize: 20)),],
          ),
          // ignore: sized_box_for_whitespace
          Container(
            width: screenWidth,
            child: TextField(
              controller: _notesField,
              decoration: const InputDecoration(labelText: 'Add Notes', border: OutlineInputBorder()),
              maxLines: 20,
              minLines: 5,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: const Text('Save')),
        ],
      ),
    );
  }
}