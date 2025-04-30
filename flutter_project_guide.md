# Flutter Project Setup Guide

## Project Structure
```
lib/
 ├─ main.dart
 ├─ resources/
 │   ├─ app_strings.dart
 │   ├─ app_colors.dart
 │   ├─ hive_boxes.dart
 │   └─ hive_keys.dart
 ├─ models/
 │   └─ [model_name].dart
 ├─ services/
 │   ├─ interfaces.dart
 │   └─ [service_name]_service.dart
 ├─ view_models/
 │   └─ [feature]_view_model.dart
 ├─ views/
 │   ├─ [feature]/
 │   │   ├─ [feature]_screen.dart
 │   │   └─ widgets/
 │   └─ common/
 │       └─ [common_widget].dart
 ├─ utils/
 │   ├─ extensions.dart
 │   └─ [utility].dart
 └─ generated/ (auto-generated)
```

## Dependencies
Add these to `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  path_provider: ^2.1.2
  flutter_local_notifications: ^17.1.0
  in_app_purchase: ^4.2.3
  collection: ^1.18.0
  timezone: ^0.9.2
  uuid: ^4.3.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.9
  hive_generator: ^2.0.1
```

## Best Practices

### 1. State Management
- Use Provider for state management
- Create separate ViewModels for each feature
- Keep business logic in services
- Use interfaces for services

### 2. Data Storage
- Use Hive for local storage
- Create model classes with Hive annotations
- Generate adapters using build_runner
- Keep box names in constants

### 3. UI Components
- Follow Material 3 design
- Use common widgets for reusability
- Keep strings in app_strings.dart
- Keep colors in app_colors.dart

### 4. Services
- Create interfaces for all services
- Implement platform-specific code in services
- Handle errors gracefully
- Use async/await for operations

### 5. Models
- Use immutable models where possible
- Include proper type annotations
- Add documentation for complex fields
- Use factory constructors when needed

### 6. Views
- Keep screens simple and focused
- Extract widgets for reusability
- Use const constructors
- Follow single responsibility principle

### 7. Utils
- Create extension methods for common operations
- Keep utility functions pure
- Add proper documentation
- Use meaningful names

### 8. Testing
- Write unit tests for services
- Write widget tests for UI
- Mock dependencies
- Test edge cases

### 9. Platform Configuration

#### iOS (Info.plist)
```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
<key>NSUserNotificationUsageDescription</key>
<string>We need to send you notifications about upcoming events.</string>
```

#### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
<uses-permission android:name="android.permission.VIBRATE" />
<uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
<uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
```

## Code Generation
Run after adding Hive models:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Common Patterns

### ViewModel Pattern
```dart
class FeatureViewModel extends ChangeNotifier {
  final IStorageService storage;
  List<Model> items = [];

  FeatureViewModel(this.storage);

  Future<void> load() async {
    items = await storage.getItems();
    notifyListeners();
  }
}
```

### Service Pattern
```dart
abstract class IService {
  Future<void> init();
  // ... other methods
}

class Service implements IService {
  @override
  Future<void> init() async {
    // initialization code
  }
}
```

### Model Pattern
```dart
@HiveType(typeId: 0)
class Model extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Model({
    required this.id,
    required this.name,
  });
}
```

## Error Handling
- Use try-catch blocks for async operations
- Log errors appropriately
- Show user-friendly error messages
- Handle edge cases gracefully

## Performance
- Use const constructors
- Implement proper dispose methods
- Avoid unnecessary rebuilds
- Use lazy loading when possible

## Security
- Store sensitive data securely
- Validate user input
- Use proper authentication
- Follow platform security guidelines

## Accessibility
- Use semantic labels
- Support screen readers
- Provide proper contrast
- Support different text sizes

## Internationalization
- Use string constants
- Support RTL layouts
- Format dates and numbers properly
- Handle different locales

## Documentation
- Add documentation for public APIs
- Keep README up to date
- Document complex logic
- Add inline comments when needed

## ID Generation
- Using UUID v4 for generating unique IDs
- This ensures globally unique identifiers
- Prevents ID collisions
- More suitable for distributed systems
- Better than timestamp-based IDs

## Font
- Using Quicksand font family
- Regular, Bold, and Light weights
- Kid-friendly, rounded design
- Good readability

## Notifications
- Using flutter_local_notifications
- Request permissions on app start
- Handle notification taps
- Schedule notifications for events

## In-App Purchases
- Using in_app_purchase package
- Handle purchase flow
- Verify purchases
- Restore purchases
- Manage subscription status

## Version Control
- Use meaningful commit messages
- Create feature branches
- Review code before merging
- Keep master branch stable

## Deployment
- Follow Flutter deployment guide
- Test on multiple devices
- Handle version updates
- Monitor app performance 