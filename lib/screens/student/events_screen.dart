/// Events screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: DemoDataService.events.length,
        itemBuilder: (context, index) {
          final event = DemoDataService.events[index];
          final colors = [const Color(0xFF6C63FF), const Color(0xFF14B8A6), const Color(0xFFEC4899), const Color(0xFFF97316)];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              Container(height: 120, width: double.infinity, decoration: BoxDecoration(
                gradient: LinearGradient(colors: [colors[index % 4], colors[index % 4].withValues(alpha: 0.7)])),
                child: Center(child: Icon(Icons.event_rounded, size: 48, color: Colors.white.withValues(alpha: 0.5)))),
              Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: colors[index % 4].withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                    child: Text(event.category.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors[index % 4], letterSpacing: 1))),
                  const Spacer(),
                  if (event.isUpcoming) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                    child: const Text('UPCOMING', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green))),
                ]),
                const SizedBox(height: 12),
                Text(event.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(event.description, style: Theme.of(context).textTheme.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(children: [
                  const Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(Helpers.formatDate(event.date), style: Theme.of(context).textTheme.bodySmall),
                  if (event.venue != null) ...[
                    const SizedBox(width: 16),
                    const Icon(Icons.location_on_rounded, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(event.venue!, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ]),
              ])),
            ]),
          );
        },
      ),
    );
  }
}
