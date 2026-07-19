/// Student Dashboard - Main screen with bottom navigation
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_campus/core/constants/app_constants.dart';
import 'package:e_campus/core/providers/auth_provider.dart';
import 'package:e_campus/core/providers/theme_provider.dart';
import 'package:e_campus/core/routes/app_router.dart';
import 'package:e_campus/core/services/demo_data_service.dart';
import 'package:e_campus/core/utils/helpers.dart';
import 'package:e_campus/widgets/common_widgets.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(context, user?.name ?? 'Student', isDark),
          _buildAcademicsTab(context),
          _buildServicesTab(context),
          _buildProfileTab(context, user, isDark),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.school_rounded), label: 'Academics'),
            BottomNavigationBarItem(icon: Icon(Icons.apps_rounded), label: 'Services'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.aiChatbot),
        tooltip: 'AI Assistant',
        child: const Icon(Icons.smart_toy_rounded),
      ),
    );
  }

  // ══════════════════════════════════════════
  // HOME TAB
  // ══════════════════════════════════════════
  Widget _buildHomeTab(BuildContext context, String name, bool isDark) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          expandedHeight: 180,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(gradient: AppGradients.primary),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Helpers.greetingMessage(),
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                name.split(' ').first,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, AppRoutes.notifications),
                                icon: Stack(
                                  children: [
                                    const Icon(Icons.notifications_outlined,
                                        color: Colors.white, size: 28),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFF6B6B),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.studentProfile),
                                child: Hero(
                                  tag: 'profile_avatar',
                                  child: CircleAvatar(
                                    radius: 22,
                                    backgroundColor:
                                        Colors.white.withValues(alpha: 0.2),
                                    child: Text(
                                      Helpers.getInitials(name),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Stats cards
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Grid
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    StatCard(
                      title: 'Attendance',
                      value: '${DemoDataService.overallAttendance.toStringAsFixed(0)}%',
                      icon: Icons.fact_check_rounded,
                      color: const Color(0xFF6C63FF),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.attendance),
                    ),
                    StatCard(
                      title: 'Assignments',
                      value: '${DemoDataService.assignments.where((a) => a.status == "active").length}',
                      icon: Icons.assignment_rounded,
                      color: const Color(0xFFFF6B6B),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.assignments),
                    ),
                    StatCard(
                      title: 'CGPA',
                      value: '8.5',
                      icon: Icons.trending_up_rounded,
                      color: const Color(0xFF14B8A6),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.results),
                    ),
                    StatCard(
                      title: 'Due Fees',
                      value: '₹${((DemoDataService.fees.where((f) => f.status != 'paid').fold<double>(0, (sum, f) => sum + f.pendingAmount)) / 1000).toStringAsFixed(0)}K',
                      icon: Icons.payment_rounded,
                      color: const Color(0xFFF97316),
                      onTap: () => Navigator.pushNamed(context, AppRoutes.fees),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Today's Timetable
                _sectionHeader(context, "Today's Classes", Icons.schedule_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.timetable)),
                const SizedBox(height: 12),
                _buildTodayTimetable(isDark),
                const SizedBox(height: 24),

                // Quick Actions
                _sectionHeader(context, 'Quick Actions', Icons.bolt_rounded, null),
                const SizedBox(height: 12),
                _buildQuickActions(context),
                const SizedBox(height: 24),

                // Recent Notifications
                _sectionHeader(context, 'Recent Updates', Icons.campaign_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.notifications)),
                const SizedBox(height: 12),
                _buildRecentNotifications(isDark),
                const SizedBox(height: 24),

                // Upcoming Events
                _sectionHeader(context, 'Upcoming Events', Icons.event_rounded,
                    () => Navigator.pushNamed(context, AppRoutes.events)),
                const SizedBox(height: 12),
                _buildUpcomingEvents(isDark),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title, IconData icon,
      VoidCallback? onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: const Text('See All'),
          ),
      ],
    );
  }

  Widget _buildTodayTimetable(bool isDark) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final today = days[DateTime.now().weekday - 1];
    final todayClasses = DemoDataService.timetable
        .where((t) => t.day == today)
        .toList()
      ..sort((a, b) => a.period.compareTo(b.period));

    if (todayClasses.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.celebration_rounded, size: 48,
                  color: Colors.amber.shade400),
              const SizedBox(height: 12),
              Text('No Classes Today!',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text('Enjoy your day off',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      );
    }

    return Column(
      children: todayClasses.take(3).map((entry) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${entry.period}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            title: Text(entry.subjectName,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(
              '${entry.startTime} - ${entry.endTime} • ${entry.room ?? 'TBA'}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              entry.facultyName?.split(' ').last ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickAction('Attendance', Icons.fact_check_rounded, const Color(0xFF6C63FF), AppRoutes.attendance),
      _QuickAction('Timetable', Icons.schedule_rounded, const Color(0xFF14B8A6), AppRoutes.timetable),
      _QuickAction('Notes', Icons.note_rounded, const Color(0xFFF97316), AppRoutes.notes),
      _QuickAction('Results', Icons.assessment_rounded, const Color(0xFFEF4444), AppRoutes.results),
      _QuickAction('Library', Icons.local_library_rounded, const Color(0xFFA855F7), AppRoutes.library),
      _QuickAction('Fees', Icons.payment_rounded, const Color(0xFF06B6D4), AppRoutes.fees),
      _QuickAction('Leave', Icons.event_busy_rounded, const Color(0xFFEC4899), AppRoutes.leaveApplication),
      _QuickAction('ID Card', Icons.qr_code_rounded, const Color(0xFF22C55E), AppRoutes.qrIdCard),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, action.route),
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: action.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(action.icon, color: action.color, size: 26),
              ),
              const SizedBox(height: 6),
              Text(
                action.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecentNotifications(bool isDark) {
    return Column(
      children: DemoDataService.notifications.take(3).map((notif) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _notifColor(notif.type).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(_notifIcon(notif.type),
                  color: _notifColor(notif.type), size: 20),
            ),
            title: Text(notif.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Text(
              Helpers.timeAgo(notif.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: const Icon(Icons.chevron_right_rounded, size: 20),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUpcomingEvents(bool isDark) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: DemoDataService.events.length,
        itemBuilder: (context, index) {
          final event = DemoDataService.events[index];
          final colors = [
            const Color(0xFF6C63FF),
            const Color(0xFF14B8A6),
            const Color(0xFFEC4899),
            const Color(0xFFF97316),
          ];
          return Container(
            width: 240,
            margin: EdgeInsets.only(right: index < DemoDataService.events.length - 1 ? 12 : 0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors[index % colors.length],
                  colors[index % colors.length].withValues(alpha: 0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    event.category.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded,
                            color: Colors.white70, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          Helpers.formatDate(event.date),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _notifIcon(String type) {
    switch (type) {
      case 'assignment':
        return Icons.assignment_rounded;
      case 'event':
        return Icons.event_rounded;
      case 'result':
        return Icons.assessment_rounded;
      case 'announcement':
        return Icons.campaign_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _notifColor(String type) {
    switch (type) {
      case 'assignment':
        return const Color(0xFF6C63FF);
      case 'event':
        return const Color(0xFF14B8A6);
      case 'result':
        return const Color(0xFFEF4444);
      case 'announcement':
        return const Color(0xFFF97316);
      default:
        return const Color(0xFF6B7280);
    }
  }

  // ══════════════════════════════════════════
  // ACADEMICS TAB
  // ══════════════════════════════════════════
  Widget _buildAcademicsTab(BuildContext context) {
    final items = [
      _MenuItem('Attendance', Icons.fact_check_rounded, const Color(0xFF6C63FF), AppRoutes.attendance),
      _MenuItem('Timetable', Icons.schedule_rounded, const Color(0xFF14B8A6), AppRoutes.timetable),
      _MenuItem('Subjects', Icons.book_rounded, const Color(0xFFA855F7), AppRoutes.subjects),
      _MenuItem('Assignments', Icons.assignment_rounded, const Color(0xFFFF6B6B), AppRoutes.assignments),
      _MenuItem('Notes', Icons.note_rounded, const Color(0xFFF97316), AppRoutes.notes),
      _MenuItem('Results', Icons.assessment_rounded, const Color(0xFFEF4444), AppRoutes.results),
      _MenuItem('Faculty', Icons.people_rounded, const Color(0xFF06B6D4), AppRoutes.facultyList),
      _MenuItem('Academic Calendar', Icons.calendar_month_rounded, const Color(0xFFEC4899), AppRoutes.events),
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Academics'),
            automaticallyImplyLeading: false,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return _buildMenuCard(context, item);
                },
                childCount: items.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════
  // SERVICES TAB
  // ══════════════════════════════════════════
  Widget _buildServicesTab(BuildContext context) {
    final items = [
      _MenuItem('Library', Icons.local_library_rounded, const Color(0xFFA855F7), AppRoutes.library),
      _MenuItem('Fees', Icons.payment_rounded, const Color(0xFF14B8A6), AppRoutes.fees),
      _MenuItem('Leave', Icons.event_busy_rounded, const Color(0xFFEC4899), AppRoutes.leaveApplication),
      _MenuItem('Events', Icons.event_rounded, const Color(0xFFF97316), AppRoutes.events),
      _MenuItem('Hostel', Icons.apartment_rounded, const Color(0xFF06B6D4), AppRoutes.hostel),
      _MenuItem('Transport', Icons.directions_bus_rounded, const Color(0xFF22C55E), AppRoutes.bus),
      _MenuItem('Placement', Icons.work_rounded, const Color(0xFF6C63FF), AppRoutes.placement),
      _MenuItem('Complaints', Icons.report_rounded, const Color(0xFFEF4444), AppRoutes.complaint),
      _MenuItem('Feedback', Icons.rate_review_rounded, const Color(0xFF14B8A6), AppRoutes.feedback),
      _MenuItem('ID Card', Icons.badge_rounded, const Color(0xFFA855F7), AppRoutes.qrIdCard),
      _MenuItem('Chat', Icons.chat_rounded, const Color(0xFF6C63FF), AppRoutes.chat),
      _MenuItem('Emergency', Icons.emergency_rounded, const Color(0xFFEF4444), AppRoutes.emergencyContacts),
      _MenuItem('Campus Map', Icons.map_rounded, const Color(0xFF22C55E), AppRoutes.campusMap),
      _MenuItem('AI Chatbot', Icons.smart_toy_rounded, const Color(0xFFF97316), AppRoutes.aiChatbot),
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Services'),
            automaticallyImplyLeading: false,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return _buildMenuCard(context, item);
                },
                childCount: items.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, _MenuItem item) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, item.route),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.color, size: 24),
              ),
              Text(
                item.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════
  // PROFILE TAB
  // ══════════════════════════════════════════
  Widget _buildProfileTab(BuildContext context, dynamic user, bool isDark) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile header
            Hero(
              tag: 'profile_avatar',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color(0xFF6C63FF),
                child: Text(
                  Helpers.getInitials(user?.name ?? 'U'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'Student',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            if (user?.rollNumber != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  user!.rollNumber!,
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 32),

            // Profile menu items
            _buildProfileItem(context, Icons.person_outlined, 'Edit Profile',
                () => Navigator.pushNamed(context, AppRoutes.studentProfile)),
            _buildProfileItem(context, Icons.qr_code_rounded, 'Student ID Card',
                () => Navigator.pushNamed(context, AppRoutes.qrIdCard)),
            _buildProfileItem(
                context,
                Icons.dark_mode_rounded,
                'Dark Mode',
                () => context.read<ThemeProvider>().toggleTheme(),
                trailing: Switch(
                  value: isDark,
                  onChanged: (_) =>
                      context.read<ThemeProvider>().toggleTheme(),
                )),
            _buildProfileItem(context, Icons.settings_rounded, 'Settings',
                () => Navigator.pushNamed(context, AppRoutes.settings)),
            _buildProfileItem(context, Icons.help_outline_rounded, 'Help & Support', () {}),
            _buildProfileItem(context, Icons.info_outline_rounded, 'About', () {}),
            const SizedBox(height: 16),
            _buildProfileItem(
              context,
              Icons.logout_rounded,
              'Logout',
              () async {
                final confirm = await Helpers.showConfirmDialog(
                  context,
                  title: 'Logout',
                  message: 'Are you sure you want to logout?',
                  confirmText: 'Logout',
                );
                if (confirm && context.mounted) {
                  await context.read<AuthProvider>().logout();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (route) => false);
                  }
                }
              },
              isDestructive: true,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isDestructive = false,
    Widget? trailing,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: (isDestructive
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary)
                .withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
              color: isDestructive
                  ? Colors.red
                  : Theme.of(context).colorScheme.primary,
              size: 22),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : null,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.chevron_right_rounded, size: 22),
        onTap: onTap,
      ),
    );
  }
}

class _QuickAction {
  final String label;
  final IconData icon;
  final Color color;
  final String route;
  const _QuickAction(this.label, this.icon, this.color, this.route);
}

class _MenuItem {
  final String label;
  final IconData icon;
  final Color color;
  final String route;
  const _MenuItem(this.label, this.icon, this.color, this.route);
}
