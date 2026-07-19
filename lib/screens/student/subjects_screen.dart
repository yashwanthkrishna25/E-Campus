/// Subjects screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = DemoDataService.subjects;
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: subjects.length,
        itemBuilder: (context, index) {
          final s = subjects[index];
          final colors = [const Color(0xFF6C63FF), const Color(0xFF14B8A6), const Color(0xFFEC4899), const Color(0xFFF97316), const Color(0xFFA855F7), const Color(0xFF22C55E)];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: colors[index % 6].withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(s.code.substring(0, 2), style: TextStyle(fontWeight: FontWeight.bold, color: colors[index % 6])))),
              title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${s.code} • ${s.credits} Credits • ${s.type}'),
              trailing: Text(s.facultyName?.split(' ').last ?? '', style: Theme.of(context).textTheme.bodySmall),
            ),
          );
        },
      ),
    );
  }
}
