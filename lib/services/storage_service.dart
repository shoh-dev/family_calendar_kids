import 'package:hive/hive.dart';
import '../models/family_event.dart';
import '../models/settings.dart';
import '../resources/hive_boxes.dart';
import 'interfaces.dart';

class StorageService implements IStorageService {
  static const String _eventsBoxName = 'events';
  static const String _settingsBoxName = 'settings';

  late Box<FamilyEvent> _eventBox;
  late Box<Settings> _settingsBox;

  @override
  Future<void> init() async {
    _eventBox = await Hive.openBox<FamilyEvent>(_eventsBoxName);
    _settingsBox = await Hive.openBox<Settings>(_settingsBoxName);

    // Ensure settings singleton exists
    if (_settingsBox.isEmpty) {
      await _settingsBox.put('settings', Settings.defaultSettings());
    }
  }

  // Events -----------------------------------------------------------------
  @override
  Future<List<FamilyEvent>> getEvents() async => _eventBox.values.toList();

  @override
  Future<void> upsertEvent(FamilyEvent event) async =>
      _eventBox.put(event.id, event);

  @override
  Future<void> deleteEvent(String id) async => _eventBox.delete(id);

  // Settings ---------------------------------------------------------------
  @override
  Future<Settings?> getSettings() async => _settingsBox.get('settings');

  @override
  Future<void> saveSettings(Settings settings) async =>
      _settingsBox.put('settings', settings);

  // Premium status
  Future<bool> getPremiumStatus() async {
    final settings = await getSettings();
    return settings?.isPremium ?? false;
  }

  Future<void> setPremiumStatus(bool value) async {
    final settings = await getSettings();
    if (settings != null) {
      await saveSettings(settings.copyWith(isPremium: value));
    }
  }
}
