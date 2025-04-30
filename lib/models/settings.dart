import 'package:hive/hive.dart';
part 'settings.g.dart';

@HiveType(typeId: 2)
class Settings extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int themeId;

  @HiveField(2)
  final bool isDarkMode;

  @HiveField(3)
  final bool notificationsEnabled;

  @HiveField(4)
  final int notificationHour;

  @HiveField(5)
  final String? selectedKidId;

  @HiveField(6)
  final int nextNotificationId;

  Settings({
    required this.id,
    required this.themeId,
    required this.isDarkMode,
    required this.notificationsEnabled,
    this.notificationHour = 0,
    this.selectedKidId,
    this.nextNotificationId = 0,
  });

  factory Settings.defaultSettings() {
    return Settings(
      id: 'default',
      themeId: 0,
      isDarkMode: false,
      notificationsEnabled: true,
    );
  }

  Settings copyWith({
    String? id,
    int? themeId,
    bool? isDarkMode,
    bool? notificationsEnabled,
    int? notificationHour,
    String? selectedKidId,
    int? nextNotificationId,
  }) {
    return Settings(
      id: id ?? this.id,
      themeId: themeId ?? this.themeId,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationHour: notificationHour ?? this.notificationHour,
      selectedKidId: selectedKidId ?? this.selectedKidId,
      nextNotificationId: nextNotificationId ?? this.nextNotificationId,
    );
  }
}
