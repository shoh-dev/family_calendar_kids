import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/app_view_model.dart';
import '../../view_models/purchase_view_model.dart';
import '../../resources/app_strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<int>(
              value: context.watch<AppViewModel>().settings?.themeId ?? 0,
              items: const [
                DropdownMenuItem(value: 0, child: Text('Blue')),
                DropdownMenuItem(value: 1, child: Text('Yellow')),
                DropdownMenuItem(value: 2, child: Text('Coral')),
                DropdownMenuItem(value: 3, child: Text('Mint')),
                DropdownMenuItem(value: 4, child: Text('Purple')),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.read<AppViewModel>().toggleTheme(value);
                }
              },
            ),
          ),
          if (!context.watch<PurchaseViewModel>().isPremium)
            ListTile(
              title: const Text(AppStrings.upgrade),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context.read<PurchaseViewModel>().buyPremium();
              },
            ),
        ],
      ),
    );
  }
}
