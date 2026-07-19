/// Leave application screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:e_campus/widgets/custom_text_field.dart';
import 'package:e_campus/widgets/gradient_button.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({super.key});
  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final _reasonController = TextEditingController();
  String _leaveType = 'casual';
  DateTime? _fromDate, _toDate;

  @override
  void dispose() { _reasonController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Leave'), bottom: const TabBar(tabs: [Tab(text: 'Apply'), Tab(text: 'History')])),
        body: TabBarView(children: [
          // Apply tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Leave Type', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(spacing: 8, children: ['casual', 'sick', 'od', 'emergency'].map((type) =>
                ChoiceChip(label: Text(type.toUpperCase()), selected: _leaveType == type,
                  onSelected: (s) => setState(() => _leaveType = type))).toList()),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: GestureDetector(
                  onTap: () async { final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 60))); if (d != null) setState(() => _fromDate = d); },
                  child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('From', style: Theme.of(context).textTheme.bodySmall), const SizedBox(height: 4),
                    Text(_fromDate != null ? Helpers.formatDateShort(_fromDate!) : 'Select Date', style: const TextStyle(fontWeight: FontWeight.w600)),
                  ]))))),
                const SizedBox(width: 12),
                Expanded(child: GestureDetector(
                  onTap: () async { final d = await showDatePicker(context: context, initialDate: _fromDate ?? DateTime.now(), firstDate: _fromDate ?? DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 60))); if (d != null) setState(() => _toDate = d); },
                  child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('To', style: Theme.of(context).textTheme.bodySmall), const SizedBox(height: 4),
                    Text(_toDate != null ? Helpers.formatDateShort(_toDate!) : 'Select Date', style: const TextStyle(fontWeight: FontWeight.w600)),
                  ]))))),
              ]),
              const SizedBox(height: 16),
              CustomTextField(controller: _reasonController, hintText: 'Enter reason for leave', labelText: 'Reason', maxLines: 4, prefixIcon: Icons.note_rounded),
              const SizedBox(height: 24),
              GradientButton(text: 'Submit Application', icon: Icons.send_rounded, onPressed: () {
                if (_fromDate == null || _toDate == null || _reasonController.text.isEmpty) { Helpers.showSnackBar(context, 'Please fill all fields', isError: true); return; }
                Helpers.showSnackBar(context, 'Leave application submitted!'); _reasonController.clear(); setState(() { _fromDate = null; _toDate = null; });
              }),
            ]),
          ),
          // History tab
          ListView.builder(
            padding: const EdgeInsets.all(16), itemCount: DemoDataService.leaveRequests.length,
            itemBuilder: (context, index) {
              final l = DemoDataService.leaveRequests[index];
              return Card(margin: const EdgeInsets.only(bottom: 10), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [Icon(Icons.event_busy_rounded, size: 18, color: Theme.of(context).colorScheme.primary), const SizedBox(width: 8),
                    Text(l.type.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary, fontSize: 13))]),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Helpers.statusColor(l.status).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                    child: Text(l.status.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Helpers.statusColor(l.status)))),
                ]),
                const SizedBox(height: 8),
                Text(l.reason, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text('${Helpers.formatDateShort(l.fromDate)} — ${Helpers.formatDateShort(l.toDate)} (${l.totalDays} days)', style: Theme.of(context).textTheme.bodySmall),
              ])));
            }),
        ]),
      ),
    );
  }
}
