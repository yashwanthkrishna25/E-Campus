/// Placement screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class PlacementScreen extends StatelessWidget {
  const PlacementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Placement Cell')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: DemoDataService.placements.length,
        itemBuilder: (context, index) {
          final p = DemoDataService.placements[index];
          final colors = {'placement': const Color(0xFF6C63FF), 'internship': const Color(0xFF14B8A6), 'hackathon': const Color(0xFFF97316), 'training': const Color(0xFFEC4899)};
          final color = colors[p.type] ?? const Color(0xFF6B7280);
          return Card(margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(p.companyName[0], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.companyName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(p.role, style: Theme.of(context).textTheme.bodySmall),
              ])),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(p.type.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color))),
            ]),
            const SizedBox(height: 12),
            Text(p.description, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            if (p.package != null) Row(children: [const Icon(Icons.currency_rupee_rounded, size: 14, color: Colors.grey), const SizedBox(width: 4), Text(p.package!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))]),
            const SizedBox(height: 4),
            Row(children: [const Icon(Icons.timer_rounded, size: 14, color: Colors.grey), const SizedBox(width: 4), Text('Deadline: ${Helpers.formatDate(p.deadline)}', style: Theme.of(context).textTheme.bodySmall)]),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Helpers.showSnackBar(context, 'Apply functionality needs Firebase'), child: const Text('Apply Now'))),
          ])));
        }),
    );
  }
}
