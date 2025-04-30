import 'package:family_calendar_kids/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/family_event.dart';
import 'models/event_category.dart';
import 'resources/app_strings.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';
import 'services/purchase_service.dart';
import 'view_models/app_view_model.dart';
import 'view_models/event_view_model.dart';
import 'view_models/purchase_view_model.dart';
import 'views/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Clear Hive boxes to handle model changes
  await Hive.deleteBoxFromDisk('events');
  await Hive.deleteBoxFromDisk('settings');
  await Hive.deleteBoxFromDisk('kids');

  // Register Hive adapters
  Hive.registerAdapter(FamilyEventAdapter());
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(EventCategoryAdapter());

  final storage = StorageService();
  await storage.init();
  final notificationService = NotificationService();
  await notificationService.init();
  final purchaseService = PurchaseService();

  runApp(
    MyApp(
      storage: storage,
      notificationService: notificationService,
      purchaseService: purchaseService,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.storage,
    required this.notificationService,
    required this.purchaseService,
  });

  final StorageService storage;
  final NotificationService notificationService;
  final PurchaseService purchaseService;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppViewModel(storage)..load()),
        ChangeNotifierProvider(create: (_) => EventViewModel(storage)..load()),
        ChangeNotifierProvider(
          create: (_) => PurchaseViewModel(purchaseService),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
