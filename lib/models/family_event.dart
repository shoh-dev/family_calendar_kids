import 'package:hive/hive.dart';
import 'event_category.dart';

part 'family_event.g.dart';

@HiveType(typeId: 0)
class FamilyEvent extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime date; // midnight

  @HiveField(3)
  final EventCategory category;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final bool isRecurring;

  @HiveField(6)
  final String? recurrenceRule;

  @HiveField(7)
  DateTime createdAt;

  @HiveField(8)
  DateTime updatedAt;

  FamilyEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    this.description,
    this.isRecurring = false,
    this.recurrenceRule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();
}
