/// Assignments screen with tabs for active and completed
library;

import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final active = DemoDataService.assignments.where((a) => a.status == 'active').toList();
    final closed = DemoDataService.assignments.where((a) => a.status == 'closed').toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assignments'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Active'), Tab(text: 'Completed')],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(context, active, true),
            _buildList(context, closed, false),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List items, bool isActive) {
    if (items.isEmpty) {
      return const Center(child: Text('No assignments'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final a = items[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (isActive ? const Color(0xFF6C63FF) : Colors.green).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isActive ? Icons.assignment_rounded : Icons.check_circle_rounded,
                        color: isActive ? const Color(0xFF6C63FF) : Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                          const SizedBox(height: 2),
                          Text(a.subjectName, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Helpers.statusColor(a.isOverdue ? 'overdue' : a.status).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        a.isOverdue ? 'Overdue' : a.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Helpers.statusColor(a.isOverdue ? 'overdue' : a.status),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(a.description, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text('Due: ${Helpers.formatDate(a.dueDate)}', style: Theme.of(context).textTheme.bodySmall),
                    const Spacer(),
                    Text('${a.totalMarks} marks', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                if (isActive) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Helpers.showSnackBar(context, 'Assignment submission UI - Connect to Firebase for file upload');
                      },
                      icon: const Icon(Icons.upload_file_rounded, size: 18),
                      label: const Text('Submit'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
