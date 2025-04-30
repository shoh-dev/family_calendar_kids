import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../models/family_event.dart';
import '../resources/hive_keys.dart';
import 'interfaces.dart';

class NotificationService implements INotificationService {
  final _fln = FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    tz.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _fln.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
  }

  @override
  Future<void> scheduleTodayReminder(
    FamilyEvent event,
    int notificationId,
  ) async {
    final date = tz.TZDateTime(
      tz.local,
      event.date.year,
      event.date.month,
      event.date.day,
      8,
    ); // 8 AM by default
    final androidDetails = AndroidNotificationDetails(
      'events_channel',
      'Event Reminders',
      channelDescription: 'Daily event reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    await _fln.zonedSchedule(
      notificationId,
      'Today is ${event.title}!',
      'Tap to open the app.',
      date,
      NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: '${HiveKeys.payloadEventId}:${event.id}',
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  @override
  Future<void> cancel(int notificationId) => _fln.cancel(notificationId);
}
