import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkoutList extends StatefulWidget {
  final Box workoutList;
  const WorkoutList({super.key, required this.workoutList});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: ListView.builder(
        itemCount: widget.workoutList.length,
        itemBuilder: (context, index) {
          var value = widget.workoutList.getAt(index);
          return Padding(
            padding: const EdgeInsets.only(left:20, right:20, bottom: 1),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, index);
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ListTile(
                  tileColor: Colors.amber,
                  title: Text(value.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Workouts: ${value.workouts}'),
                      Text('Work Areas: ${value.workAreas?.join(', ') ?? 'No Work Areas'}'),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}