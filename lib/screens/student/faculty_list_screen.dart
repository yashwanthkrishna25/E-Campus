/// Faculty list screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class FacultyListScreen extends StatelessWidget {
  const FacultyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faculty = DemoDataService.facultyMembers;
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: faculty.length,
        itemBuilder: (context, index) {
          final f = faculty[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(radius: 28, backgroundColor: const Color(0xFF6C63FF), child: Text(Helpers.getInitials(f.name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              title: Text(f.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${f.designation ?? "Faculty"} • ${f.department ?? ""}'),
              trailing: IconButton(icon: const Icon(Icons.chat_rounded, color: Color(0xFF6C63FF)), onPressed: () => Helpers.showSnackBar(context, 'Chat with ${f.name}')),
            ),
          );
        },
      ),
    );
  }
}
