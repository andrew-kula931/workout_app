import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WorkoutData {
  String name;
  String workouts;
  List<String> muscleGroups;

  WorkoutData({required this.name, required this.workouts, required this.muscleGroups});
}

class WorkoutDataAdapter extends TypeAdapter<WorkoutData> {
  @override
  final typeId = 0;

  @override
  WorkoutData read(BinaryReader reader) {
    return WorkoutData(
      name: reader.read(),
      workouts: reader.read(),
      muscleGroups: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutData obj) {
    writer.write(obj.name);
    writer.write(obj.workouts);
    writer.write(obj.muscleGroups);
  }
}