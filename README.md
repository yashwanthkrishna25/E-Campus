# 🎓 E-Campus – Smart Digital Campus Management System

E-Campus is a high-performance, production-ready, and feature-rich digital college ecosystem designed to eliminate paperwork and connect students, faculty, and administrators onto a single responsive Flutter platform.

This product has been crafted with a **Material 3 UI design language**, utilising advanced **Glassmorphism, custom gradients, subsecond navigation, and dynamic state management** via Provider. It compiles beautifully across **iOS, Android, Windows desktop, and Web platforms**.

---

## 🚀 Key Features

E-Campus offers complete digitisation of university and college life across three dedicated roles:

### 👨‍🎓 Student Portal (15+ Screens)
*   **Dynamic Dashboard:** Personalised greeting, real-time overall attendance widget, active assignment counters, CGPA charts, and pending fee alerts.
*   **Academic Tracker:** Interactive day-by-day timetable grids, subject attendance counters with visual progress thresholds, and marks analytics.
*   **Resource Center:** Lecture notes downloader sorted by subject and file type, active & completed assignments tracking with submission capabilities.
*   **Campus Services:** QR ID Card Generator, Digital Library Catalog, Online Fees Gateway mockup, leave application management, hostel/room info, bus/transport route listings.
*   **Communication:** Grievance box (Complaints), Feedback forms, Group chats, and notifications box.

### 👩‍🏫 Faculty Portal (12+ Screens)
*   **Attendance Registry:** Quick radio-selectors to mark and record daily student attendance.
*   **Assignment Manager:** Post new assignments with descriptions, deadlines, and grade structures.
*   **Academic Gradebook:** Record internal marks, mid-terms, and final exam grades.
*   **Leave Approvals:** Interactive response sheet to accept/reject student leave requests.
*   **Broadcaster:** Send real-time announcements or notices to targeted classes.

### 🔑 Administrator Portal (15+ Screens)
*   **Analytics Hub:** Dynamic cards displaying counts of active students, faculty, courses, and departments.
*   **Systems Catalog:** Complete CRUD controls for Student/Faculty records, Course registers, and Timetables.
*   **System Operations:** SQL backups database configuration, fee audits, and campus-wide emergency notifications.

### 🤖 Shared Common Screens
*   **AI Chatbot:** Immediate student support built with predefined responses for attendance, fees, schedules, and assignment status.
*   **Sleek Settings Panel:** Toggle theme modes (Light & Dark) instantly, update notification profiles, and view credentials.
*   **Emergency SOS Directory:** Direct access list of warden, HOD, registrar, security, and healthcare helpline contacts.
*   **Campus Map Directory:** Interactive list of departments, labs, canteen, and sports complex locations.

---

## 🛠️ Tech Stack & Architecture

*   **Framework:** Flutter (Latest Stable)
*   **State Management:** Provider
*   **Local Storage:** Shared Preferences
*   **Typography:** Poppins (Google Fonts)
*   **Icons & Indicators:** Line Icons & Circular Percent Indicators
*   **Graphics & Charts:** FL Chart
*   **Backend Integration:** Ready for Cloud Firestore, Firebase Auth, Storage, and Cloud Messaging.

The codebase is built on **Clean Coding Principles** separating:
```text
lib/
├── core/
│   ├── constants/    # Global Colors, Gradients, and App Strings
│   ├── providers/    # AuthProvider, ThemeProvider (State Management)
│   ├── routes/       # Dynamic cross-screen Named Routes
│   ├── services/     # DemoDataService for offline mock trials
│   └── utils/        # Validation rules, Time converters, and Helpers
├── models/           # Dart Object classes mapping to Cloud Firestore
├── screens/          # Splitted by Roles (Student, Faculty, Admin, Common, Auth)
├── widgets/          # Custom reusable UI elements (GlassCard, CustomTextField, Buttons)
└── main.dart         # Provider bootstrapping and MaterialApp router
```

---

## ⚡ Setup & Local Run Instructions

### Prerequisites
1.  Install the [Flutter SDK](https://docs.flutter.dev/get-started/install).
2.  Set up an Editor (dependencies support VS Code or Android Studio).
3.  Ready a target device (Chrome web browser, Windows desktop, or Emulator).

### Step 1: Clone and Restore Packages
Restore all Dart package dependencies by running:
```bash
flutter pub get
```

### Step 2: Run in Demo Mode (Default)
In default developer mode, the app runs offline using a pre-populated mock dataset via `DemoDataService` so you can show the UI/UX instantly:
```bash
# Run on Chrome
flutter run -d chrome

# Run on Windows Desktop
flutter run -d windows
```

### Step 3: Run Widget Smoke Tests
Execute the unit and layout smoke test to verify all routes verify correctly:
```bash
flutter test
```

---

## ☁️ Production Firebase Setup

To connect to your live Firebase backend:

### 1. Initialize Firebase Projects
Create a project on the [Firebase Console](https://console.firebase.google.com/) and register:
*   **Android App** (add download `google-services.json` to `android/app/`)
*   **iOS App** (copy `GoogleService-Info.plist` into `ios/Runner/`)
*   **Web App** (use `firebase login` and register configuration keys)

### 2. Configure main.dart
In `lib/main.dart`, uncomment the Firebase initialization lines:
```dart
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Uncomment after completing Firebase CLI configurations:
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(const ECampusApp());
}
```

### 3. Transition from Mock Data
Switch the services within core Providers (`lib/core/providers/auth_provider.dart`) from fetching mock lists in `DemoDataService` to query matching CollectionReferences:
```dart
// Example: Query student records:
FirebaseFirestore.instance.collection('students').snapshots();
```

---

## 🎨 Premium UI/UX Showcase
E-Campus boasts full support for Material 3 design features:
*   **Dynamic Gradients:** Customized gradients matching active student status indicators.
*   **Glassmorphism Cards:** Translucent visual elements displaying profile information.
*   **System Dark Mode toggle:** Automatic card re-tinting and text contrast adjustment.

---
Developed as a smart modular template ready for College/Final-Year Demo and GitHub portfolios!
