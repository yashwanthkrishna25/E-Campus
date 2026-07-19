/// QR ID Card screen
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:e_campus/core/providers/auth_provider.dart';
import 'package:e_campus/core/utils/helpers.dart';

class QrIdCardScreen extends StatelessWidget {
  const QrIdCardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Student ID Card')),
      body: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Container(
        width: 350, padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 10))]),
        child: ClipRRect(borderRadius: BorderRadius.circular(24), child: Column(children: [
          // Header
          Container(padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFF4158D0)])),
            child: Column(children: [
              const Text('E-CAMPUS', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 3)),
              const SizedBox(height: 4),
              Text('Student Identity Card', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
              const SizedBox(height: 20),
              CircleAvatar(radius: 40, backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: Text(Helpers.getInitials(user?.name ?? 'U'), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))),
              const SizedBox(height: 12),
              Text(user?.name ?? 'Student', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(user?.rollNumber ?? '', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
            ])),
          // Details
          Container(color: Theme.of(context).cardTheme.color ?? Colors.white, padding: const EdgeInsets.all(24), child: Column(children: [
            _row(context, 'Department', user?.department ?? 'N/A'),
            _row(context, 'Course', user?.course ?? 'N/A'),
            _row(context, 'Semester', user?.semester ?? 'N/A'),
            _row(context, 'Email', user?.email ?? 'N/A'),
            const SizedBox(height: 16),
            QrImageView(data: 'ECAMPUS:${user?.uid}:${user?.rollNumber}:${user?.name}', version: QrVersions.auto, size: 150),
            const SizedBox(height: 8),
            Text('Scan for verification', style: Theme.of(context).textTheme.bodySmall),
          ])),
        ])),
      ))),
    );
  }
  Widget _row(BuildContext context, String label, String value) {
    return Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: Theme.of(context).textTheme.bodySmall), Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    ]));
  }
}
