import 'package:flutter/material.dart';
import '../../../models/family_event.dart';
import '../../../utils/extensions.dart';
import '../../../utils/date_utils.dart';
import '../../add_edit_event/add_edit_event_screen.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});
  final FamilyEvent event;

  @override
  Widget build(BuildContext context) {
    final sleeps = DateTime.now().atMidnight.sleepsUntil(event.date);
    final theme = Theme.of(context);
    final isToday = sleeps == 0;

    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.primary.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEditEventScreen(event: event)),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surface,
                theme.colorScheme.primaryContainer.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        event.category.icon,
                        color: theme.colorScheme.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          if (event.description != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              event.description!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.7,
                                ),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color:
                        isToday
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (isToday
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary)
                            .withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isToday ? Icons.celebration : Icons.bedtime,
                        size: 24,
                        color:
                            isToday
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isToday
                            ? 'Today is the day! 🎉'
                            : '$sleeps ${sleeps == 1 ? 'sleep' : 'sleeps'} until ${event.category.displayName}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color:
                              isToday
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
