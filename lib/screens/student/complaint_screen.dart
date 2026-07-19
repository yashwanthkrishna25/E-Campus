/// Complaint screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:e_campus/widgets/custom_text_field.dart';
import 'package:e_campus/widgets/gradient_button.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});
  @override State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _subjectController = TextEditingController();
  final _descController = TextEditingController();
  String _category = 'other';

  @override void dispose() { _subjectController.dispose(); _descController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(title: const Text('Complaints'), bottom: const TabBar(tabs: [Tab(text: 'New'), Tab(text: 'History')])),
      body: TabBarView(children: [
        SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Category', style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 8),
          Wrap(spacing: 8, children: ['academic', 'hostel', 'infrastructure', 'other'].map((c) =>
            ChoiceChip(label: Text(c.toUpperCase()), selected: _category == c, onSelected: (s) => setState(() => _category = c))).toList()),
          const SizedBox(height: 16),
          CustomTextField(controller: _subjectController, hintText: 'Subject', labelText: 'Subject', prefixIcon: Icons.subject_rounded),
          const SizedBox(height: 16),
          CustomTextField(controller: _descController, hintText: 'Describe your complaint', labelText: 'Description', maxLines: 5, prefixIcon: Icons.description_rounded),
          const SizedBox(height: 24),
          GradientButton(text: 'Submit Complaint', icon: Icons.send_rounded, gradient: const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFEC4899)]),
            onPressed: () { if (_subjectController.text.isEmpty || _descController.text.isEmpty) { Helpers.showSnackBar(context, 'Fill all fields', isError: true); return; }
              Helpers.showSnackBar(context, 'Complaint submitted!'); _subjectController.clear(); _descController.clear(); }),
        ])),
        ListView.builder(padding: const EdgeInsets.all(16), itemCount: DemoDataService.complaints.length,
          itemBuilder: (context, index) { final c = DemoDataService.complaints[index];
            return Card(margin: const EdgeInsets.only(bottom: 10), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Text(c.subject, style: const TextStyle(fontWeight: FontWeight.w600))),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Helpers.statusColor(c.status).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(c.status.toUpperCase().replaceAll('_', ' '), style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Helpers.statusColor(c.status)))),
              ]),
              const SizedBox(height: 8), Text(c.description, style: Theme.of(context).textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
              if (c.response != null) ...[const SizedBox(height: 8), Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.reply_rounded, size: 16, color: Colors.green), const SizedBox(width: 8), Expanded(child: Text(c.response!, style: const TextStyle(fontSize: 12, color: Colors.green)))]))],
              const SizedBox(height: 8), Text(Helpers.timeAgo(c.createdAt), style: Theme.of(context).textTheme.bodySmall),
            ])));
          }),
      ]),
    ));
  }
}
