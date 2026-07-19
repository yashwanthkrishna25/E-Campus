/// Notes screen - view and download study materials
library;

import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes & Materials')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DemoDataService.notes.length,
        itemBuilder: (context, index) {
          final note = DemoDataService.notes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: _fileColor(note.fileType).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_fileIcon(note.fileType), color: _fileColor(note.fileType)),
              ),
              title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(note.subjectName, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 2),
                  Text('${note.fileSizeFormatted} • ${Helpers.timeAgo(note.uploadedAt)}',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.download_rounded),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () => Helpers.showSnackBar(context, 'Download started: ${note.title}'),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _fileIcon(String type) {
    switch (type) {
      case 'pdf': return Icons.picture_as_pdf_rounded;
      case 'doc': return Icons.description_rounded;
      case 'ppt': return Icons.slideshow_rounded;
      default: return Icons.insert_drive_file_rounded;
    }
  }

  Color _fileColor(String type) {
    switch (type) {
      case 'pdf': return const Color(0xFFEF4444);
      case 'doc': return const Color(0xFF3B82F6);
      case 'ppt': return const Color(0xFFF97316);
      default: return const Color(0xFF6B7280);
    }
  }
}
