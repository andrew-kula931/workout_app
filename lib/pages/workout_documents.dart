import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/workout_db.dart';

class WorkoutArchive extends StatefulWidget {
  const WorkoutArchive({super.key});

  @override
  State<WorkoutArchive> createState() => _WorkoutArchiveState();
}

class _WorkoutArchiveState extends State<WorkoutArchive> {
  late List<WorkoutDb> filteredList;

  @override
  void initState() {
    super.initState();
    Box<WorkoutDb> workouts = Hive.box('Workout');
    List<WorkoutDb> filteredList = workouts.values.where((workout) => workout.day != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Documented Workouts', style: TextStyle(fontSize: 40))]
        ),
        Flexible(
          child: ListView.builder(
            itemCount: filteredList.length, //Needs to make this dynamic
            itemBuilder: (context, index) {
              var doc = filteredList[index];
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
    );
  }
}