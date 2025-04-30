import 'package:flutter/foundation.dart';
import '../models/family_event.dart';
import '../models/event_category.dart';
import '../services/interfaces.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class EventViewModel extends ChangeNotifier {
  final StorageService _storageService;
  final NotificationService _notificationService;
  List<FamilyEvent> _events = [];
  String _searchQuery = '';
  EventCategory? _selectedCategory;

  EventViewModel(this._storageService, this._notificationService) {
    _loadEvents();
  }

  List<FamilyEvent> get events => _events;
  String get searchQuery => _searchQuery;
  EventCategory? get selectedCategory => _selectedCategory;

  Future<void> _loadEvents() async {
    _events = await _storageService.getEvents();
    _events.sort((a, b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  Future<void> load() => _loadEvents();

  Future<void> addEvent(FamilyEvent event) async {
    await _storageService.upsertEvent(event);
    await _notificationService.scheduleTodayReminder(event, event.id.hashCode);
    await _loadEvents();
  }

  Future<void> updateEvent(FamilyEvent event) async {
    await _storageService.upsertEvent(event);
    await _notificationService.scheduleTodayReminder(event, event.id.hashCode);
    await _loadEvents();
  }

  Future<void> deleteEvent(String id) async {
    await _storageService.deleteEvent(id);
    await _notificationService.cancel(id.hashCode);
    await _loadEvents();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(EventCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<FamilyEvent> getFilteredEvents() {
    return _events.where((event) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final matchesSearch =
            event.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (event.description?.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ??
                false);
        if (!matchesSearch) return false;
      }

      // Category filter
      if (_selectedCategory != null && event.category != _selectedCategory) {
        return false;
      }

      return true;
    }).toList();
  }

  List<FamilyEvent> getUpcomingEvents() {
    final now = DateTime.now();
    return _events.where((event) => event.date.isAfter(now)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  List<FamilyEvent> getEventsForDate(DateTime date) {
    return _events
        .where(
          (event) =>
              event.date.year == date.year &&
              event.date.month == date.month &&
              event.date.day == date.day,
        )
        .toList();
  }
}
