// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FamilyEventAdapter extends TypeAdapter<FamilyEvent> {
  @override
  final int typeId = 0;

  @override
  FamilyEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FamilyEvent(
      id: fields[0] as String,
      title: fields[1] as String,
      date: fields[2] as DateTime,
      category: fields[3] as EventCategory,
      description: fields[4] as String?,
      isRecurring: fields[5] as bool,
      recurrenceRule: fields[6] as String?,
      createdAt: fields[7] as DateTime?,
      updatedAt: fields[8] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, FamilyEvent obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.isRecurring)
      ..writeByte(6)
      ..write(obj.recurrenceRule)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
