import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_db.dart';

class WorkoutArchive extends StatefulWidget {
  const WorkoutArchive({super.key});

  @override
  State<WorkoutArchive> createState() => _WorkoutArchiveState();
}

class _WorkoutArchiveState extends State<WorkoutArchive> {
  late List<dynamic> _filteredList;

  @override
  void initState() {
    super.initState();
    _filteredList = Hive.box('Workout').values.where((workout) => workout.day != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documented Workouts'),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: _filteredList.length, //Needs to make this dynamic
              itemBuilder: (context, index) {
                var doc = _filteredList[index];
                return ListTile(
                  title: Text(doc.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Workouts: ${doc.workouts}'),
                      Text('Work Areas: ${doc.workAreas?.join(', ') ?? 'No Areas'}'),
                      Text('Day: ${doc.day.toString()}'),
                    ],
                  ),
                );
              }
            ),
          ),

          //Bottom record button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  //build bottom sheet
                },
                child: const Text('Record Workout')
              ),
            ],
          ),
        ]
      )
    );
  }
}