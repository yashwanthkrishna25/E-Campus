/// Campus Map screen (placeholder with visual)
library;
import 'package:flutter/material.dart';

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final buildings = [
      _Building('Main Building', Icons.business_rounded, const Color(0xFF6C63FF), 'Administrative offices, Principal\'s Office'),
      _Building('Academic Block A', Icons.school_rounded, const Color(0xFF14B8A6), 'CSE & ECE Departments'),
      _Building('Academic Block B', Icons.school_rounded, const Color(0xFFA855F7), 'ME & CE Departments'),
      _Building('Library', Icons.local_library_rounded, const Color(0xFFF97316), 'Central Library - 50,000+ books'),
      _Building('Auditorium', Icons.theater_comedy_rounded, const Color(0xFFEC4899), 'Main Auditorium - 1000 seats'),
      _Building('Sports Complex', Icons.sports_basketball_rounded, const Color(0xFF22C55E), 'Indoor & Outdoor sports facilities'),
      _Building('Cafeteria', Icons.restaurant_rounded, const Color(0xFFEF4444), 'Main Canteen & Food Court'),
      _Building('Boys Hostel', Icons.apartment_rounded, const Color(0xFF06B6D4), 'Block A & B'),
      _Building('Girls Hostel', Icons.apartment_rounded, const Color(0xFFEC4899), 'Block C'),
      _Building('Parking', Icons.local_parking_rounded, const Color(0xFF6B7280), 'Student & Staff parking'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Campus Map')),
      body: Column(children: [
        // Map placeholder
        Container(height: 200, margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.green.shade100, Colors.green.shade50]),
            borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.green.shade200)),
          child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.map_rounded, size: 48, color: Colors.green.shade400),
            const SizedBox(height: 8),
            Text('Interactive Campus Map', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green.shade700)),
            Text('Coming soon with Google Maps integration', style: TextStyle(fontSize: 12, color: Colors.green.shade500)),
          ]))),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Align(alignment: Alignment.centerLeft, child: Text('Campus Buildings', style: Theme.of(context).textTheme.headlineSmall))),
        const SizedBox(height: 8),
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: buildings.length,
          itemBuilder: (context, index) {
            final b = buildings[index];
            return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(
              leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: b.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(b.icon, color: b.color, size: 22)),
              title: Text(b.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(b.description, style: Theme.of(context).textTheme.bodySmall),
            ));
          })),
      ]),
    );
  }
}
class _Building { final String name; final IconData icon; final Color color; final String description; const _Building(this.name, this.icon, this.color, this.description); }
