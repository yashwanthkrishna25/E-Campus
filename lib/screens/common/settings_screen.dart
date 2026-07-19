/// Settings screen
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_campus/core/providers/auth_provider.dart';
import 'package:e_campus/core/providers/theme_provider.dart';
import 'package:e_campus/core/routes/app_router.dart';
import 'package:e_campus/core/utils/helpers.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _section(context, 'Appearance'),
        Card(child: Column(children: [
          SwitchListTile(
            title: const Text('Dark Mode'), subtitle: const Text('Switch between light and dark theme'),
            secondary: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
            value: isDark, onChanged: (_) => context.read<ThemeProvider>().toggleTheme()),
        ])),
        const SizedBox(height: 16),
        _section(context, 'Notifications'),
        Card(child: Column(children: [
          SwitchListTile(title: const Text('Push Notifications'), subtitle: const Text('Receive push notifications'), secondary: const Icon(Icons.notifications_rounded), value: true, onChanged: (_) {}),
          SwitchListTile(title: const Text('Email Notifications'), subtitle: const Text('Receive email updates'), secondary: const Icon(Icons.email_rounded), value: false, onChanged: (_) {}),
        ])),
        const SizedBox(height: 16),
        _section(context, 'Account'),
        Card(child: Column(children: [
          ListTile(leading: const Icon(Icons.lock_rounded), title: const Text('Change Password'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => Helpers.showSnackBar(context, 'Password change requires Firebase Auth')),
          ListTile(leading: const Icon(Icons.language_rounded), title: const Text('Language'), subtitle: const Text('English'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () {}),
          ListTile(leading: const Icon(Icons.storage_rounded), title: const Text('Clear Cache'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () => Helpers.showSnackBar(context, 'Cache cleared')),
        ])),
        const SizedBox(height: 16),
        _section(context, 'About'),
        Card(child: Column(children: [
          const ListTile(leading: Icon(Icons.info_rounded), title: Text('Version'), subtitle: Text('1.0.0')),
          ListTile(leading: const Icon(Icons.privacy_tip_rounded), title: const Text('Privacy Policy'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () {}),
          ListTile(leading: const Icon(Icons.description_rounded), title: const Text('Terms of Service'), trailing: const Icon(Icons.chevron_right_rounded), onTap: () {}),
        ])),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
          onPressed: () async { final confirm = await Helpers.showConfirmDialog(context, title: 'Logout', message: 'Are you sure?', confirmText: 'Logout');
            if (confirm && context.mounted) { await context.read<AuthProvider>().logout(); if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false); }},
          icon: const Icon(Icons.logout_rounded), label: const Text('Logout')),
      ]),
    );
  }
  Widget _section(BuildContext context, String title) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(title, style: Theme.of(context).textTheme.titleLarge));
}
