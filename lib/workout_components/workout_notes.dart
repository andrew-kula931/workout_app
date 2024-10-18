import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkoutNotes extends StatefulWidget {
  final Box workoutNotes;
  const WorkoutNotes({super.key, required this.workoutNotes});

  @override
  State<WorkoutNotes> createState() => _WorkoutNotesState();
}

class _WorkoutNotesState extends State<WorkoutNotes> {
  TextEditingController _textField = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    var box = await Hive.openBox('WorkoutNotes');
    if (!box.containsKey('notes')) {
      box.put('notes', '');
    }
    var initialValue = box.get('notes') ?? '';
    setState(() {
      _textField = TextEditingController(text: initialValue);
    });
  }

  @override dispose() {
    _textField.dispose();
    super.dispose();
  }

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
              controller: _textField,
              decoration: const InputDecoration(labelText: 'Add Notes', border: OutlineInputBorder()),
              maxLines: 20,
              minLines: 5,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var box = Hive.box('WorkoutNotes');
              if (box.containsKey('notes')) {
                await box.put('notes', _textField.text);
              } else {
                await box.put('notes', _textField.text);
              }
              
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }, 
            child: const Text('Save')),
        ],
      ),
    );
  }
}