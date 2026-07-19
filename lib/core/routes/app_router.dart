/// App routing configuration with named routes
library;

import 'package:flutter/material.dart';
import 'package:e_campus/screens/splash/splash_screen.dart';
import 'package:e_campus/screens/onboarding/onboarding_screen.dart';
import 'package:e_campus/screens/auth/login_screen.dart';
import 'package:e_campus/screens/auth/register_screen.dart';
import 'package:e_campus/screens/auth/forgot_password_screen.dart';
import 'package:e_campus/screens/student/student_dashboard.dart';
import 'package:e_campus/screens/faculty/faculty_dashboard.dart';
import 'package:e_campus/screens/admin/admin_dashboard.dart';
import 'package:e_campus/screens/student/attendance_screen.dart';
import 'package:e_campus/screens/student/assignments_screen.dart';
import 'package:e_campus/screens/student/notes_screen.dart';
import 'package:e_campus/screens/student/results_screen.dart';
import 'package:e_campus/screens/student/fees_screen.dart';
import 'package:e_campus/screens/student/library_screen.dart';
import 'package:e_campus/screens/student/events_screen.dart';
import 'package:e_campus/screens/student/timetable_screen.dart';
import 'package:e_campus/screens/student/subjects_screen.dart';
import 'package:e_campus/screens/student/faculty_list_screen.dart';
import 'package:e_campus/screens/student/leave_application_screen.dart';
import 'package:e_campus/screens/student/hostel_screen.dart';
import 'package:e_campus/screens/student/bus_screen.dart';
import 'package:e_campus/screens/student/placement_screen.dart';
import 'package:e_campus/screens/student/complaint_screen.dart';
import 'package:e_campus/screens/student/feedback_screen.dart';
import 'package:e_campus/screens/student/qr_id_card_screen.dart';
import 'package:e_campus/screens/student/student_profile_screen.dart';
import 'package:e_campus/screens/common/notifications_screen.dart';
import 'package:e_campus/screens/common/chat_screen.dart';
import 'package:e_campus/screens/common/settings_screen.dart';
import 'package:e_campus/screens/common/emergency_contacts_screen.dart';
import 'package:e_campus/screens/common/ai_chatbot_screen.dart';
import 'package:e_campus/screens/common/campus_map_screen.dart';

class AppRoutes {
  AppRoutes._();

  // ──── Route Names ────
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Student
  static const String studentDashboard = '/student/dashboard';
  static const String studentProfile = '/student/profile';
  static const String attendance = '/student/attendance';
  static const String assignments = '/student/assignments';
  static const String notes = '/student/notes';
  static const String results = '/student/results';
  static const String fees = '/student/fees';
  static const String library = '/student/library';
  static const String events = '/student/events';
  static const String timetable = '/student/timetable';
  static const String subjects = '/student/subjects';
  static const String facultyList = '/student/faculty-list';
  static const String leaveApplication = '/student/leave';
  static const String hostel = '/student/hostel';
  static const String bus = '/student/bus';
  static const String placement = '/student/placement';
  static const String complaint = '/student/complaint';
  static const String feedback = '/student/feedback';
  static const String qrIdCard = '/student/qr-id';

  // Faculty
  static const String facultyDashboard = '/faculty/dashboard';

  // Admin
  static const String adminDashboard = '/admin/dashboard';

  // Common
  static const String notifications = '/notifications';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String emergencyContacts = '/emergency-contacts';
  static const String aiChatbot = '/ai-chatbot';
  static const String campusMap = '/campus-map';

  // ──── Route Generator ────
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return _fadeRoute(const SplashScreen(), routeSettings);
      case onboarding:
        return _fadeRoute(const OnboardingScreen(), routeSettings);
      case login:
        return _slideRoute(const LoginScreen(), routeSettings);
      case register:
        return _slideRoute(const RegisterScreen(), routeSettings);
      case forgotPassword:
        return _slideRoute(const ForgotPasswordScreen(), routeSettings);

      // Student Routes
      case studentDashboard:
        return _fadeRoute(const StudentDashboard(), routeSettings);
      case studentProfile:
        return _slideRoute(const StudentProfileScreen(), routeSettings);
      case attendance:
        return _slideRoute(const AttendanceScreen(), routeSettings);
      case assignments:
        return _slideRoute(const AssignmentsScreen(), routeSettings);
      case notes:
        return _slideRoute(const NotesScreen(), routeSettings);
      case results:
        return _slideRoute(const ResultsScreen(), routeSettings);
      case fees:
        return _slideRoute(const FeesScreen(), routeSettings);
      case library:
        return _slideRoute(const LibraryScreen(), routeSettings);
      case events:
        return _slideRoute(const EventsScreen(), routeSettings);
      case timetable:
        return _slideRoute(const TimetableScreen(), routeSettings);
      case subjects:
        return _slideRoute(const SubjectsScreen(), routeSettings);
      case facultyList:
        return _slideRoute(const FacultyListScreen(), routeSettings);
      case leaveApplication:
        return _slideRoute(const LeaveApplicationScreen(), routeSettings);
      case hostel:
        return _slideRoute(const HostelScreen(), routeSettings);
      case bus:
        return _slideRoute(const BusScreen(), routeSettings);
      case placement:
        return _slideRoute(const PlacementScreen(), routeSettings);
      case complaint:
        return _slideRoute(const ComplaintScreen(), routeSettings);
      case feedback:
        return _slideRoute(const FeedbackScreen(), routeSettings);
      case qrIdCard:
        return _slideRoute(const QrIdCardScreen(), routeSettings);

      // Faculty Routes
      case facultyDashboard:
        return _fadeRoute(const FacultyDashboard(), routeSettings);

      // Admin Routes
      case adminDashboard:
        return _fadeRoute(const AdminDashboard(), routeSettings);

      // Common Routes
      case notifications:
        return _slideRoute(const NotificationsScreen(), routeSettings);
      case chat:
        return _slideRoute(const ChatScreen(), routeSettings);
      case settings:
        return _slideRoute(const SettingsScreen(), routeSettings);
      case emergencyContacts:
        return _slideRoute(const EmergencyContactsScreen(), routeSettings);
      case aiChatbot:
        return _slideRoute(const AiChatbotScreen(), routeSettings);
      case campusMap:
        return _slideRoute(const CampusMapScreen(), routeSettings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route not found: ${routeSettings.name}')),
          ),
        );
    }
  }

  // ──── Custom Transitions ────
  static PageRouteBuilder _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  static PageRouteBuilder _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: Curves.easeInOutCubic));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
