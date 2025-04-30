import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/event_view_model.dart';
import '../../utils/extensions.dart';
import '../../resources/app_strings.dart';
import '../add_edit_event/add_edit_event_screen.dart';
import '../settings/settings_screen.dart';
import 'widgets/countdown_banner.dart';
import 'widgets/event_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = context.watch<EventViewModel>().events;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body:
          events.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.event_note,
                      size: 64,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No events yet!',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap + to add your first event',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
              : Column(
                children: [
                  if (events.isNotEmpty) CountdownBanner(event: events.first),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: events.length,
                      itemBuilder:
                          (_, i) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: EventCard(event: events[i]),
                          ),
                    ),
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditEventScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Event'),
      ),
    );
  }
}
