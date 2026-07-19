/// Bus/Transport screen
library;
import 'package:flutter/material.dart';
import 'package:e_campus/core/services/demo_data_service.dart';

class BusScreen extends StatelessWidget {
  const BusScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transport')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16), itemCount: DemoDataService.busRoutes.length,
        itemBuilder: (context, index) {
          final bus = DemoDataService.busRoutes[index];
          return Card(margin: const EdgeInsets.only(bottom: 12), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFF22C55E).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Center(child: Text(bus.routeNumber, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF22C55E))))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(bus.routeName, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('Bus: ${bus.busNumber ?? "N/A"} • ${bus.departureTime} - ${bus.arrivalTime}', style: Theme.of(context).textTheme.bodySmall),
              ]))]),
            const SizedBox(height: 12),
            Text('Stops:', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            Wrap(spacing: 6, runSpacing: 6, children: bus.stops.asMap().entries.map((e) => Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: e.key == 0 ? Colors.green : e.key == bus.stops.length - 1 ? Colors.red : Colors.grey, shape: BoxShape.circle)),
              const SizedBox(width: 4), Text(e.value, style: const TextStyle(fontSize: 12)),
              if (e.key < bus.stops.length - 1) const Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Text('→', style: TextStyle(color: Colors.grey))),
            ])).toList()),
            const SizedBox(height: 8),
            Text('Driver: ${bus.driverName} | ${bus.driverPhone}', style: Theme.of(context).textTheme.bodySmall),
          ])));
        }),
    );
  }
}
