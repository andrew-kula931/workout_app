import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout/workout_components/edit_workout.dart';
import '../workout_components/workout_list.dart';

/*

Need to create new Hive Box for documented workouts


*/


class WorkoutArchive extends StatefulWidget {
  const WorkoutArchive({super.key});

  @override
  State<WorkoutArchive> createState() => _WorkoutArchiveState();
}

class _WorkoutArchiveState extends State<WorkoutArchive> {
  late List<dynamic> _filteredList;
  late final Box workoutList;

  @override
  void initState() {
    super.initState();
    workoutList = Hive.box('Workout');
    _filteredList = Hive.box('Workout').values.where((workout) => workout.day != null).toList();
  }

  Future<void> _getWorkout() async {
    final result = await showModalBottomSheet<int>(
      context: context,
      builder: (context) {
        return WorkoutList(workoutList: workoutList);
      }
    );
    if (result != null) {
      showModalBottomSheet(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (context) {
          return EditWorkout(workoutDb: workoutList, index: result, time: true);
        }
      ).then((value) {
        setState(() {});
      });
    }
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
              Padding(
                padding: const EdgeInsets.all(6),
                child: ElevatedButton(
                  onPressed: () {
                    _getWorkout();
                  },
                  child: const Text('Record Workout')
                ),
              ),
            ],
          ),
        ]
      )
    );
  }
}