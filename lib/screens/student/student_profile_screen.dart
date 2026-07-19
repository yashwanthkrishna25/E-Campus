/// Student Profile screen
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_campus/core/providers/auth_provider.dart';
import 'package:e_campus/core/utils/helpers.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
        const SizedBox(height: 20),
        Hero(tag: 'profile_avatar', child: CircleAvatar(radius: 50, backgroundColor: const Color(0xFF6C63FF),
          child: Text(Helpers.getInitials(user?.name ?? 'U'), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)))),
        const SizedBox(height: 8),
        TextButton.icon(onPressed: () => Helpers.showSnackBar(context, 'Photo upload requires Firebase Storage'),
          icon: const Icon(Icons.camera_alt_rounded, size: 18), label: const Text('Change Photo')),
        const SizedBox(height: 16),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
          _profileRow(context, 'Name', user?.name ?? 'N/A', Icons.person_rounded),
          _profileRow(context, 'Email', user?.email ?? 'N/A', Icons.email_rounded),
          _profileRow(context, 'Phone', user?.phone ?? 'N/A', Icons.phone_rounded),
          _profileRow(context, 'Roll Number', user?.rollNumber ?? 'N/A', Icons.tag_rounded),
          _profileRow(context, 'Department', user?.department ?? 'N/A', Icons.business_rounded),
          _profileRow(context, 'Course', user?.course ?? 'N/A', Icons.school_rounded),
          _profileRow(context, 'Semester', user?.semester ?? 'N/A', Icons.calendar_today_rounded),
          _profileRow(context, 'Bio', user?.bio ?? 'N/A', Icons.info_rounded, isLast: true),
        ]))),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: OutlinedButton.icon(
          onPressed: () => Helpers.showSnackBar(context, 'Profile edit requires Firebase integration'),
          icon: const Icon(Icons.edit_rounded), label: const Text('Edit Profile'))),
      ])),
    );
  }
  Widget _profileRow(BuildContext context, String label, String value, IconData icon, {bool isLast = false}) {
    return Column(children: [
      Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Row(children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ]),
      ])),
      if (!isLast) const Divider(height: 0),
    ]);
  }
}
