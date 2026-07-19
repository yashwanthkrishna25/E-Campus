/// Faculty Dashboard with management features
library;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_campus/core/providers/auth_provider.dart';
import 'package:e_campus/core/providers/theme_provider.dart';
import 'package:e_campus/core/routes/app_router.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:e_campus/widgets/common_widgets.dart';

class FacultyDashboard extends StatefulWidget {
  const FacultyDashboard({super.key});
  @override State<FacultyDashboard> createState() => _FacultyDashboardState();
}

class _FacultyDashboardState extends State<FacultyDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: [
        _buildHome(context, user?.name ?? 'Faculty', isDark),
        _buildManage(context),
        _buildProfile(context, user, isDark),
      ]),
      bottomNavigationBar: BottomNavigationBar(currentIndex: _currentIndex, onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts_rounded), label: 'Manage'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ]),
    );
  }

  Widget _buildHome(BuildContext context, String name, bool isDark) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 160, floating: false, pinned: true, automaticallyImplyLeading: false,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF14B8A6), Color(0xFF06B6D4)])),
            child: SafeArea(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(Helpers.greetingMessage(), style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(name.split(' ').last, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ]),
                Row(children: [
                  IconButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.notifications),
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 28)),
                  CircleAvatar(radius: 22, backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: Text(Helpers.getInitials(name), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ]),
              ]),
            ])))))),

      SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Stats
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5, children: [
            StatCard(title: 'Students', value: '${DemoDataService.students.length}', icon: Icons.people_rounded, color: const Color(0xFF6C63FF)),
            StatCard(title: 'Subjects', value: '${DemoDataService.subjects.length}', icon: Icons.book_rounded, color: const Color(0xFF14B8A6)),
            StatCard(title: 'Assignments', value: '${DemoDataService.assignments.length}', icon: Icons.assignment_rounded, color: const Color(0xFFF97316)),
            StatCard(title: 'Leave Requests', value: '${DemoDataService.leaveRequests.where((l) => l.status == "pending").length}', icon: Icons.event_busy_rounded, color: const Color(0xFFEC4899)),
          ]),
        const SizedBox(height: 24),

        Text("Today's Classes", style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...DemoDataService.timetable.where((t) {
          final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
          return t.day == days[DateTime.now().weekday - 1] && t.facultyName == 'Dr. Priya Patel';
        }).take(4).map((t) => Card(margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFF14B8A6).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text('P${t.period}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF14B8A6))))),
            title: Text(t.subjectName, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('${t.startTime} - ${t.endTime} • ${t.room ?? "TBA"}'),
          ))),

        const SizedBox(height: 24),
        Text('Pending Actions', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Card(child: ListTile(leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.event_busy_rounded, color: Colors.orange)),
          title: const Text('Leave Requests'), subtitle: const Text('1 pending approval'), trailing: const Icon(Icons.chevron_right_rounded))),
        Card(child: ListTile(leading: Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.report_rounded, color: Colors.red)),
          title: const Text('Complaints'), subtitle: const Text('1 new complaint'), trailing: const Icon(Icons.chevron_right_rounded))),

        const SizedBox(height: 80),
      ]))),
    ]);
  }

  Widget _buildManage(BuildContext context) {
    final items = [
      _M('Upload Attendance', Icons.fact_check_rounded, const Color(0xFF6C63FF)),
      _M('Update Marks', Icons.grade_rounded, const Color(0xFF14B8A6)),
      _M('Upload Notes', Icons.upload_file_rounded, const Color(0xFFA855F7)),
      _M('Manage Assignments', Icons.assignment_rounded, const Color(0xFFF97316)),
      _M('Student Profiles', Icons.people_rounded, const Color(0xFF06B6D4)),
      _M('Approve Leave', Icons.event_available_rounded, const Color(0xFFEC4899)),
      _M('Announcements', Icons.campaign_rounded, const Color(0xFFEF4444)),
      _M('Manage Timetable', Icons.schedule_rounded, const Color(0xFF22C55E)),
      _M('View Complaints', Icons.report_rounded, const Color(0xFFF97316)),
      _M('Chat with Students', Icons.chat_rounded, const Color(0xFF6C63FF)),
      _M('Performance Analytics', Icons.analytics_rounded, const Color(0xFFA855F7)),
      _M('Notifications', Icons.notifications_rounded, const Color(0xFFEF4444)),
    ];

    return SafeArea(child: CustomScrollView(slivers: [
      const SliverAppBar(title: Text('Manage'), pinned: true, automaticallyImplyLeading: false),
      SliverPadding(padding: const EdgeInsets.all(16), sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = items[index];
          return GestureDetector(onTap: () => Helpers.showSnackBar(context, '${item.label} - Connect to Firebase for full functionality'),
            child: Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: item.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(item.icon, color: item.color, size: 24)),
              Text(item.label, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
            ]))));
        }, childCount: items.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4),
      )),
    ]));
  }

  Widget _buildProfile(BuildContext context, dynamic user, bool isDark) {
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
      const SizedBox(height: 20),
      CircleAvatar(radius: 50, backgroundColor: const Color(0xFF14B8A6),
        child: Text(Helpers.getInitials(user?.name ?? 'U'), style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold))),
      const SizedBox(height: 16),
      Text(user?.name ?? 'Faculty', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 4),
      Text(user?.designation ?? '', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 4),
      Text(user?.department ?? '', style: Theme.of(context).textTheme.bodySmall),
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
class _M { final String label; final IconData icon; final Color color; const _M(this.label, this.icon, this.color); }
