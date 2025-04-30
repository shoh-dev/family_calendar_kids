// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventCategoryAdapter extends TypeAdapter<EventCategory> {
  @override
  final int typeId = 3;

  @override
  EventCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EventCategory.birthday;
      case 1:
        return EventCategory.school;
      case 2:
        return EventCategory.sports;
      case 3:
        return EventCategory.medical;
      case 4:
        return EventCategory.family;
      case 5:
        return EventCategory.other;
      default:
        return EventCategory.birthday;
    }
  }

  @override
  void write(BinaryWriter writer, EventCategory obj) {
    switch (obj) {
      case EventCategory.birthday:
        writer.writeByte(0);
        break;
      case EventCategory.school:
        writer.writeByte(1);
        break;
      case EventCategory.sports:
        writer.writeByte(2);
        break;
      case EventCategory.medical:
        writer.writeByte(3);
        break;
      case EventCategory.family:
        writer.writeByte(4);
        break;
      case EventCategory.other:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
