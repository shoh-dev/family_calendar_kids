import 'package:flutter/material.dart';
import '../../models/family_event.dart';
import '../../utils/extensions.dart';
import '../../resources/app_strings.dart';

class CountdownScreen extends StatelessWidget {
  const CountdownScreen({super.key, required this.event});
  final FamilyEvent event;

  @override
  Widget build(BuildContext context) {
    final sleeps = DateTime.now().atMidnight.sleepsUntil(event.date);
    return Scaffold(
      appBar: AppBar(title: const Text('Countdown')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$sleeps', style: context.textTheme.displayLarge),
            Text(
              AppStrings.sleepsUntil,
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            Text(event.title, style: context.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
