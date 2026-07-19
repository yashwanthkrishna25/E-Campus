/// Timetable screen with day tabs
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    final todayIndex = DateTime.now().weekday <= 5 ? DateTime.now().weekday - 1 : 0;

    return DefaultTabController(
      length: days.length, initialIndex: todayIndex,
      child: Scaffold(
        appBar: AppBar(title: const Text('Timetable'), bottom: TabBar(isScrollable: true, tabs: days.map((d) => Tab(text: d)).toList())),
        body: TabBarView(
          children: days.map((day) {
            final classes = DemoDataService.timetable.where((t) => t.day == day).toList()..sort((a, b) => a.period.compareTo(b.period));
            if (classes.isEmpty) return const Center(child: Text('No classes'));
            return ListView.builder(
              padding: const EdgeInsets.all(16), itemCount: classes.length,
              itemBuilder: (context, index) {
                final c = classes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: Center(child: Text('P${c.period}', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)))),
                    title: Text(c.subjectName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('${c.startTime} - ${c.endTime} • ${c.room ?? "TBA"}'),
                    trailing: Text(c.facultyName?.split(' ').last ?? '', style: Theme.of(context).textTheme.bodySmall),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
