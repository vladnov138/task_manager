// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      task: fields[0] as String,
      details: fields[1] as String,
      category: fields[2] as String,
      deadline: fields[3] as DateTime,
      important: fields[4] as bool,
      complete: fields[5] as bool,
      updated_at: fields[6] as DateTime,
      notificationId: fields[7] as int?,
      notificationDateTime: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.details)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.deadline)
      ..writeByte(4)
      ..write(obj.important)
      ..writeByte(5)
      ..write(obj.complete)
      ..writeByte(6)
      ..write(obj.updated_at)
      ..writeByte(7)
      ..write(obj.notificationId)
      ..writeByte(8)
      ..write(obj.notificationDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
