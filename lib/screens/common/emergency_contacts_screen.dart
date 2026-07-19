/// Emergency contacts screen with SOS button
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency')),
      body: Column(children: [
        // SOS Button
        Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFDC2626)]), borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.3), blurRadius: 16, offset: const Offset(0, 8))]),
          child: Column(children: [
            GestureDetector(
              onLongPress: () => Helpers.showSnackBar(context, 'SOS Alert sent to campus security!'),
              child: Container(width: 80, height: 80, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Center(child: Text('SOS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red))))),
            const SizedBox(height: 12),
            const Text('Long press to send SOS', style: TextStyle(color: Colors.white70, fontSize: 13)),
          ])),
        // Contacts
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: DemoDataService.emergencyContacts.length,
          itemBuilder: (context, index) {
            final c = DemoDataService.emergencyContacts[index];
            final icons = {'security': Icons.security_rounded, 'medical': Icons.local_hospital_rounded, 'fire': Icons.local_fire_department_rounded, 'police': Icons.local_police_rounded, 'ambulance': Icons.emergency_rounded, 'women': Icons.woman_rounded, 'ragging': Icons.report_rounded, 'dean': Icons.person_rounded};
            return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
              leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(icons[c['icon']] ?? Icons.phone, color: Colors.red, size: 22)),
              title: Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(c['phone']!),
              trailing: IconButton(icon: const Icon(Icons.phone_rounded, color: Colors.green), onPressed: () => Helpers.showSnackBar(context, 'Calling ${c['name']}')),
            ));
          })),
      ]),
    );
  }
}
