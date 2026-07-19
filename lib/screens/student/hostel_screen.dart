/// Hostel screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';

class HostelScreen extends StatelessWidget {
  const HostelScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hostel')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: DemoDataService.hostels.length,
        itemBuilder: (context, index) {
          final h = DemoDataService.hostels[index];
          return Card(margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Container(width: 48, height: 48, decoration: BoxDecoration(color: (h.type == 'boys' ? const Color(0xFF6C63FF) : const Color(0xFFEC4899)).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(Icons.apartment_rounded, color: h.type == 'boys' ? const Color(0xFF6C63FF) : const Color(0xFFEC4899))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(h.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                Text(h.type == 'boys' ? "Boys' Hostel" : "Girls' Hostel", style: Theme.of(context).textTheme.bodySmall),
              ]))]),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _info(context, Icons.person, 'Warden', h.wardenName ?? 'N/A'),
              _info(context, Icons.phone, 'Phone', h.wardenPhone ?? 'N/A'),]),
            const SizedBox(height: 8),
            Row(children: [
              _info(context, Icons.meeting_room, 'Total', '${h.totalRooms}'),
              const SizedBox(width: 24),
              _info(context, Icons.check_circle, 'Occupied', '${h.occupiedRooms}'),
              const SizedBox(width: 24),
              _info(context, Icons.door_back_door, 'Available', '${h.totalRooms - h.occupiedRooms}'),
            ]),
          ])));
        }),
    );
  }
  Widget _info(BuildContext context, IconData icon, String label, String value) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: Theme.of(context).textTheme.bodySmall),
      Row(children: [Icon(icon, size: 14, color: Colors.grey), const SizedBox(width: 4), Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))]),
    ]);
  }
}
