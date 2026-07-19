/// Admin Dashboard with comprehensive management
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_campus/core/providers/auth_provider.dart';
import 'package:e_campus/core/providers/theme_provider.dart';
import 'package:e_campus/core/routes/app_router.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:e_campus/widgets/common_widgets.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        _buildHome(context, user?.name ?? 'Admin'),
        _buildManage(context),
        _buildReports(context),
        _buildProfile(context, user, isDark),
      ]),
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Manage'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ]),
    );
  }

  Widget _buildHome(BuildContext context, String name) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 160, floating: false, pinned: true, automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFA855F7), Color(0xFF6366F1)])),
            child: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Admin Panel', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  const SizedBox(height: 4),
                  Text('Welcome, ${name.split(' ').first}', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ]),
                IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
                  icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 28)),
              ]),
            ])))))),

      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5, children: [
            StatCard(title: 'Students', value: '${DemoDataService.students.length * 48}', icon: Icons.people_rounded, color: const Color(0xFF6C63FF)),
            StatCard(title: 'Faculty', value: '${DemoDataService.facultyMembers.length * 13}', icon: Icons.person_rounded, color: const Color(0xFF14B8A6)),
            StatCard(title: 'Departments', value: '${DemoDataService.departments.length}', icon: Icons.business_rounded, color: const Color(0xFFA855F7)),
            StatCard(title: 'Courses', value: '${DemoDataService.courses.length}', icon: Icons.school_rounded, color: const Color(0xFFF97316)),
          ]),
        const SizedBox(height: 24),

        Text('Quick Overview', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Card(child: ListTile(leading: const Icon(Icons.event_busy, color: Colors.orange), title: const Text('Pending Leave Requests'), trailing: Text('${DemoDataService.leaveRequests.where((l) => l.status == "pending").length}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Card(child: ListTile(leading: const Icon(Icons.report, color: Colors.red), title: const Text('Open Complaints'), trailing: Text('${DemoDataService.complaints.where((c) => c.status != "resolved").length}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Card(child: ListTile(leading: const Icon(Icons.payment, color: Colors.green), title: const Text('Pending Fees'), trailing: Text('₹${(DemoDataService.fees.fold<double>(0, (s, f) => s + f.pendingAmount) / 1000).toStringAsFixed(0)}K', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        Card(child: ListTile(leading: const Icon(Icons.event, color: Colors.blue), title: const Text('Upcoming Events'), trailing: Text('${DemoDataService.events.where((e) => e.isUpcoming).length}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))),
        const SizedBox(height: 80),
      ]))),
    ]);
  }

  Widget _buildManage(BuildContext context) {
    final items = [
      _A('Students', Icons.people_rounded, const Color(0xFF6C63FF)),
      _A('Faculty', Icons.person_rounded, const Color(0xFF14B8A6)),
      _A('Courses', Icons.school_rounded, const Color(0xFFA855F7)),
      _A('Departments', Icons.business_rounded, const Color(0xFFF97316)),
      _A('Timetable', Icons.schedule_rounded, const Color(0xFF06B6D4)),
      _A('Attendance', Icons.fact_check_rounded, const Color(0xFF22C55E)),
      _A('Exams', Icons.quiz_rounded, const Color(0xFFEF4444)),
      _A('Results', Icons.assessment_rounded, const Color(0xFFEC4899)),
      _A('Fees', Icons.payment_rounded, const Color(0xFF6C63FF)),
      _A('Events', Icons.event_rounded, const Color(0xFF14B8A6)),
      _A('Library', Icons.local_library_rounded, const Color(0xFFA855F7)),
      _A('Hostel', Icons.apartment_rounded, const Color(0xFFF97316)),
      _A('Transport', Icons.directions_bus_rounded, const Color(0xFF22C55E)),
      _A('Notifications', Icons.notifications_rounded, const Color(0xFFEF4444)),
      _A('Backup', Icons.backup_rounded, const Color(0xFF6B7280)),
      _A('Settings', Icons.settings_rounded, const Color(0xFF06B6D4)),
    ];

    return SafeArea(child: CustomScrollView(slivers: [
      const SliverAppBar(title: Text('Manage'), pinned: true, automaticallyImplyLeading: false),
      SliverPadding(padding: const EdgeInsets.all(16), sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = items[index];
          return GestureDetector(onTap: () => Helpers.showSnackBar(context, 'Manage ${item.label} - Connect to Firebase'),
            child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: item.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(item.icon, color: item.color, size: 24)),
              Text(item.label, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
            ]))));
        }, childCount: items.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4),
      )),
    ]));
  }

  Widget _buildReports(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 8),
      Text('Reports & Analytics', style: Theme.of(context).textTheme.displaySmall),
      const SizedBox(height: 20),

      // Department Overview
      Text('Department Overview', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 12),
      ...DemoDataService.departments.map((d) => Card(margin: const EdgeInsets.only(bottom: 8),
        child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            _reportStat('Students', '${d.studentCount}', Colors.blue),
            _reportStat('Faculty', '${d.facultyCount}', Colors.green),
            _reportStat('HOD', d.hodName?.split(' ').last ?? 'TBA', Colors.purple),
          ]),
        ])))),

      const SizedBox(height: 24),
      Text('System Stats', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 12),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        _statRow('Total Users', '${DemoDataService.students.length + DemoDataService.facultyMembers.length + 1}'),
        _statRow('Active Students', '${DemoDataService.students.length}'),
        _statRow('Active Faculty', '${DemoDataService.facultyMembers.length}'),
        _statRow('Library Books', '${DemoDataService.libraryBooks.length}'),
        _statRow('Hostel Rooms', '${DemoDataService.hostels.fold<int>(0, (s, h) => s + h.totalRooms)}'),
        _statRow('Bus Routes', '${DemoDataService.busRoutes.length}'),
      ]))),
    ])));
  }

  Widget _reportStat(String label, String value, Color color) {
    return Column(children: [
      Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
      Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
    ]);
  }

  Widget _statRow(String label, String value) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))]));
  }

  Widget _buildProfile(BuildContext context, dynamic user, bool isDark) {
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
      const SizedBox(height: 20),
      CircleAvatar(radius: 50, backgroundColor: const Color(0xFFA855F7),
        child: Text(Helpers.getInitials(user?.name ?? 'A'), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold))),
      const SizedBox(height: 16),
      Text(user?.name ?? 'Admin', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 4),
      Text(user?.designation ?? 'System Administrator', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 32),
      Card(child: Column(children: [
        SwitchListTile(title: const Text('Dark Mode'), secondary: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
          value: isDark, onChanged: (_) => context.read<ThemeProvider>().toggleTheme()),
        ListTile(leading: const Icon(Icons.settings_rounded), title: const Text('Settings'), trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => Navigator.pushNamed(context, AppRoutes.settings)),
      ])),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        onPressed: () async { await context.read<AuthProvider>().logout(); if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (r) => false); },
        icon: const Icon(Icons.logout_rounded), label: const Text('Logout'))),
    ])));
  }
}
class _A { final String label; final IconData icon; final Color color; const _A(this.label, this.icon, this.color); }
