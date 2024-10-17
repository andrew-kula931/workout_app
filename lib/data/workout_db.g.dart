// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutDbAdapter extends TypeAdapter<WorkoutDb> {
  @override
  final int typeId = 1;

  @override
  WorkoutDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutDb(
      name: fields[0] as String,
      workouts: fields[1] as String,
      workAreas: (fields[2] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutDb obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.workouts)
      ..writeByte(2)
      ..write(obj.workAreas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
