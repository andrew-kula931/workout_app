import 'package:hive_flutter/hive_flutter.dart';

part 'workout_db.g.dart';

@HiveType(typeId: 1)
class WorkoutDb {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String workouts;

  @HiveField(2)
  late List<String>? workAreas;

  WorkoutDb({this.name = '',
    this.workouts = '',
    this.workAreas});
}

@HiveType(typeId: 2)
class WorkoutDoc {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String workouts;

  @HiveField(2)
  late List<String>? workAreas;

  @HiveField(3)
  late DateTime? day;

  WorkoutDoc({this.name = '',
    this.workouts = '',
    this.workAreas,
    this.day});
}