import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddWorkout extends StatefulWidget {
  const AddWorkout({super.key});

  @override
  State<AddWorkout> createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {


  @override
  Widget build(BuildContext context) {
    return Container (
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Add Workout'),
            ],
          ),
          Row(
            children: [
              Text('Name: '),
              TextField(decoration: InputDecoration(labelText: 'Name')),
            ],
          ),
        ],
      ),
    );
  }
}