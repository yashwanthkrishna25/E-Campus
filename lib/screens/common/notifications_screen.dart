/// Notifications screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: DemoDataService.notifications.length,
        itemBuilder: (context, index) {
          final n = DemoDataService.notifications[index];
          final icons = {'assignment': Icons.assignment_rounded, 'event': Icons.event_rounded, 'result': Icons.assessment_rounded, 'announcement': Icons.campaign_rounded, 'general': Icons.notifications_rounded};
          final colors = {'assignment': const Color(0xFF6C63FF), 'event': const Color(0xFF14B8A6), 'result': const Color(0xFFEF4444), 'announcement': const Color(0xFFF97316), 'general': const Color(0xFF6B7280)};
          return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
            leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: (colors[n.type] ?? Colors.grey).withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icons[n.type] ?? Icons.notifications, color: colors[n.type], size: 22)),
            title: Text(n.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 4), Text(n.body, style: Theme.of(context).textTheme.bodySmall, maxLines: 2),
              const SizedBox(height: 4), Text(Helpers.timeAgo(n.createdAt), style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            ]),
          ));
        }),
    );
  }
}
