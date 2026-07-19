/// Demo data service that provides sample data for the app
/// This allows the app to run WITHOUT Firebase for demonstration purposes
library;

import 'package:e_campus/core/constants/app_constants.dart';
import 'package:e_campus/core/models/user_model.dart';
import 'package:e_campus/core/models/app_models.dart';

class DemoDataService {
  DemoDataService._();

  // ──── Demo Users ────
  static final List<UserModel> students = [
    UserModel.demoStudent(),
    UserModel(
      uid: 'demo_student_2', name: 'Ananya Gupta', email: 'ananya@ecampus.com',
      role: UserRole.student, department: 'Computer Science', course: 'B.Tech CSE',
      semester: 'Semester 6', rollNumber: '20CS102', createdAt: DateTime(2024, 1, 1),
      isProfileComplete: true,
    ),
    UserModel(
      uid: 'demo_student_3', name: 'Vikram Singh', email: 'vikram@ecampus.com',
      role: UserRole.student, department: 'Electronics', course: 'B.Tech ECE',
      semester: 'Semester 4', rollNumber: '21EC101', createdAt: DateTime(2024, 1, 1),
      isProfileComplete: true,
    ),
    UserModel(
      uid: 'demo_student_4', name: 'Sneha Reddy', email: 'sneha@ecampus.com',
      role: UserRole.student, department: 'Computer Science', course: 'B.Tech CSE',
      semester: 'Semester 6', rollNumber: '20CS103', createdAt: DateTime(2024, 1, 1),
      isProfileComplete: true,
    ),
    UserModel(
      uid: 'demo_student_5', name: 'Arjun Nair', email: 'arjun@ecampus.com',
      role: UserRole.student, department: 'Mechanical', course: 'B.Tech ME',
      semester: 'Semester 2', rollNumber: '22ME101', createdAt: DateTime(2024, 1, 1),
      isProfileComplete: true,
    ),
  ];

  static final List<UserModel> facultyMembers = [
    UserModel.demoFaculty(),
    UserModel(
      uid: 'demo_faculty_2', name: 'Prof. Rajesh Kumar', email: 'rajesh@ecampus.com',
      role: UserRole.faculty, department: 'Computer Science', employeeId: 'FAC002',
      designation: 'Professor', createdAt: DateTime(2023, 6, 1), isProfileComplete: true,
    ),
    UserModel(
      uid: 'demo_faculty_3', name: 'Dr. Meena Iyer', email: 'meena@ecampus.com',
      role: UserRole.faculty, department: 'Electronics', employeeId: 'FAC003',
      designation: 'Assistant Professor', createdAt: DateTime(2023, 6, 1), isProfileComplete: true,
    ),
    UserModel(
      uid: 'demo_faculty_4', name: 'Prof. Sanjay Verma', email: 'sanjay@ecampus.com',
      role: UserRole.faculty, department: 'Mechanical', employeeId: 'FAC004',
      designation: 'Professor & HOD', createdAt: DateTime(2023, 6, 1), isProfileComplete: true,
    ),
  ];

  // ──── Demo Subjects ────
  static final List<SubjectModel> subjects = [
    const SubjectModel(id: 'sub1', name: 'Data Structures', code: 'CS301', courseId: 'cse', facultyName: 'Dr. Priya Patel', credits: 4, type: 'theory'),
    const SubjectModel(id: 'sub2', name: 'Operating Systems', code: 'CS302', courseId: 'cse', facultyName: 'Prof. Rajesh Kumar', credits: 4, type: 'theory'),
    const SubjectModel(id: 'sub3', name: 'Database Systems', code: 'CS303', courseId: 'cse', facultyName: 'Dr. Priya Patel', credits: 3, type: 'theory'),
    const SubjectModel(id: 'sub4', name: 'Computer Networks', code: 'CS304', courseId: 'cse', facultyName: 'Prof. Rajesh Kumar', credits: 3, type: 'theory'),
    const SubjectModel(id: 'sub5', name: 'Web Development Lab', code: 'CS305', courseId: 'cse', facultyName: 'Dr. Priya Patel', credits: 2, type: 'practical'),
    const SubjectModel(id: 'sub6', name: 'Machine Learning', code: 'CS306', courseId: 'cse', facultyName: 'Dr. Priya Patel', credits: 3, type: 'elective'),
  ];

  // ──── Demo Attendance Summary ────
  static final Map<String, Map<String, double>> attendanceSummary = {
    'demo_student_1': {
      'Data Structures': 85.0,
      'Operating Systems': 72.0,
      'Database Systems': 90.0,
      'Computer Networks': 68.0,
      'Web Development Lab': 95.0,
      'Machine Learning': 78.0,
    },
  };

  static double get overallAttendance {
    final vals = attendanceSummary['demo_student_1']!.values;
    return vals.reduce((a, b) => a + b) / vals.length;
  }

  // ──── Demo Timetable ────
  static final List<TimetableEntry> timetable = [
    // Monday
    const TimetableEntry(id: 't1', courseId: 'cse', day: 'Monday', period: 1, startTime: '09:00', endTime: '09:50', subjectId: 'sub1', subjectName: 'Data Structures', facultyName: 'Dr. Priya Patel', room: 'Room 301'),
    const TimetableEntry(id: 't2', courseId: 'cse', day: 'Monday', period: 2, startTime: '10:00', endTime: '10:50', subjectId: 'sub2', subjectName: 'Operating Systems', facultyName: 'Prof. Rajesh Kumar', room: 'Room 302'),
    const TimetableEntry(id: 't3', courseId: 'cse', day: 'Monday', period: 3, startTime: '11:00', endTime: '11:50', subjectId: 'sub3', subjectName: 'Database Systems', facultyName: 'Dr. Priya Patel', room: 'Room 303'),
    const TimetableEntry(id: 't4', courseId: 'cse', day: 'Monday', period: 5, startTime: '14:00', endTime: '14:50', subjectId: 'sub4', subjectName: 'Computer Networks', facultyName: 'Prof. Rajesh Kumar', room: 'Lab 1'),
    // Tuesday
    const TimetableEntry(id: 't5', courseId: 'cse', day: 'Tuesday', period: 1, startTime: '09:00', endTime: '09:50', subjectId: 'sub6', subjectName: 'Machine Learning', facultyName: 'Dr. Priya Patel', room: 'Room 305'),
    const TimetableEntry(id: 't6', courseId: 'cse', day: 'Tuesday', period: 2, startTime: '10:00', endTime: '10:50', subjectId: 'sub1', subjectName: 'Data Structures', facultyName: 'Dr. Priya Patel', room: 'Room 301'),
    const TimetableEntry(id: 't7', courseId: 'cse', day: 'Tuesday', period: 3, startTime: '11:00', endTime: '11:50', subjectId: 'sub5', subjectName: 'Web Development Lab', facultyName: 'Dr. Priya Patel', room: 'Lab 2'),
    const TimetableEntry(id: 't8', courseId: 'cse', day: 'Tuesday', period: 4, startTime: '12:00', endTime: '12:50', subjectId: 'sub5', subjectName: 'Web Development Lab', facultyName: 'Dr. Priya Patel', room: 'Lab 2'),
    // Wednesday
    const TimetableEntry(id: 't9', courseId: 'cse', day: 'Wednesday', period: 1, startTime: '09:00', endTime: '09:50', subjectId: 'sub2', subjectName: 'Operating Systems', facultyName: 'Prof. Rajesh Kumar', room: 'Room 302'),
    const TimetableEntry(id: 't10', courseId: 'cse', day: 'Wednesday', period: 2, startTime: '10:00', endTime: '10:50', subjectId: 'sub3', subjectName: 'Database Systems', facultyName: 'Dr. Priya Patel', room: 'Room 303'),
    const TimetableEntry(id: 't11', courseId: 'cse', day: 'Wednesday', period: 3, startTime: '11:00', endTime: '11:50', subjectId: 'sub4', subjectName: 'Computer Networks', facultyName: 'Prof. Rajesh Kumar', room: 'Room 304'),
    const TimetableEntry(id: 't12', courseId: 'cse', day: 'Wednesday', period: 5, startTime: '14:00', endTime: '14:50', subjectId: 'sub6', subjectName: 'Machine Learning', facultyName: 'Dr. Priya Patel', room: 'Room 305'),
    // Thursday
    const TimetableEntry(id: 't13', courseId: 'cse', day: 'Thursday', period: 1, startTime: '09:00', endTime: '09:50', subjectId: 'sub1', subjectName: 'Data Structures', facultyName: 'Dr. Priya Patel', room: 'Room 301'),
    const TimetableEntry(id: 't14', courseId: 'cse', day: 'Thursday', period: 2, startTime: '10:00', endTime: '10:50', subjectId: 'sub2', subjectName: 'Operating Systems', facultyName: 'Prof. Rajesh Kumar', room: 'Room 302'),
    const TimetableEntry(id: 't15', courseId: 'cse', day: 'Thursday', period: 4, startTime: '12:00', endTime: '12:50', subjectId: 'sub3', subjectName: 'Database Systems', facultyName: 'Dr. Priya Patel', room: 'Room 303'),
    // Friday
    const TimetableEntry(id: 't16', courseId: 'cse', day: 'Friday', period: 1, startTime: '09:00', endTime: '09:50', subjectId: 'sub4', subjectName: 'Computer Networks', facultyName: 'Prof. Rajesh Kumar', room: 'Room 304'),
    const TimetableEntry(id: 't17', courseId: 'cse', day: 'Friday', period: 2, startTime: '10:00', endTime: '10:50', subjectId: 'sub6', subjectName: 'Machine Learning', facultyName: 'Dr. Priya Patel', room: 'Room 305'),
    const TimetableEntry(id: 't18', courseId: 'cse', day: 'Friday', period: 3, startTime: '11:00', endTime: '12:50', subjectId: 'sub5', subjectName: 'Web Development Lab', facultyName: 'Dr. Priya Patel', room: 'Lab 2'),
  ];

  // ──── Demo Assignments ────
  static final List<AssignmentModel> assignments = [
    AssignmentModel(id: 'a1', title: 'Implement Binary Search Tree', description: 'Write a complete BST implementation with insert, delete, search, and traversal operations.', subjectId: 'sub1', subjectName: 'Data Structures', assignedBy: 'Dr. Priya Patel', dueDate: DateTime.now().add(const Duration(days: 5)), createdAt: DateTime.now().subtract(const Duration(days: 2)), totalMarks: 20),
    AssignmentModel(id: 'a2', title: 'Process Scheduling Simulation', description: 'Simulate FCFS, SJF, and Round Robin scheduling algorithms and compare performance.', subjectId: 'sub2', subjectName: 'Operating Systems', assignedBy: 'Prof. Rajesh Kumar', dueDate: DateTime.now().add(const Duration(days: 10)), createdAt: DateTime.now().subtract(const Duration(days: 1)), totalMarks: 15),
    AssignmentModel(id: 'a3', title: 'ER Diagram Design', description: 'Design an ER diagram for a hospital management system with at least 10 entities.', subjectId: 'sub3', subjectName: 'Database Systems', assignedBy: 'Dr. Priya Patel', dueDate: DateTime.now().subtract(const Duration(days: 2)), createdAt: DateTime.now().subtract(const Duration(days: 10)), totalMarks: 10, status: 'closed'),
    AssignmentModel(id: 'a4', title: 'Network Protocol Analysis', description: 'Use Wireshark to capture and analyze HTTP, TCP, and UDP packets. Submit a detailed report.', subjectId: 'sub4', subjectName: 'Computer Networks', assignedBy: 'Prof. Rajesh Kumar', dueDate: DateTime.now().add(const Duration(days: 15)), createdAt: DateTime.now(), totalMarks: 15),
  ];

  // ──── Demo Notes ────
  static final List<NoteModel> notes = [
    NoteModel(id: 'n1', title: 'DSA Complete Notes - Unit 1', description: 'Arrays, Linked Lists, Stacks, and Queues', subjectId: 'sub1', subjectName: 'Data Structures', uploadedBy: 'demo_faculty_1', uploadedByName: 'Dr. Priya Patel', fileUrl: 'https://example.com/dsa_unit1.pdf', fileType: 'pdf', fileSize: 2500000, uploadedAt: DateTime.now().subtract(const Duration(days: 15))),
    NoteModel(id: 'n2', title: 'OS Memory Management', description: 'Paging, Segmentation, Virtual Memory concepts', subjectId: 'sub2', subjectName: 'Operating Systems', uploadedBy: 'demo_faculty_2', uploadedByName: 'Prof. Rajesh Kumar', fileUrl: 'https://example.com/os_memory.pdf', fileType: 'pdf', fileSize: 1800000, uploadedAt: DateTime.now().subtract(const Duration(days: 10))),
    NoteModel(id: 'n3', title: 'SQL Queries Reference', description: 'Complete SQL reference with examples and practice queries', subjectId: 'sub3', subjectName: 'Database Systems', uploadedBy: 'demo_faculty_1', uploadedByName: 'Dr. Priya Patel', fileUrl: 'https://example.com/sql_ref.pdf', fileType: 'pdf', fileSize: 3200000, uploadedAt: DateTime.now().subtract(const Duration(days: 5))),
    NoteModel(id: 'n4', title: 'TCP/IP Protocol Suite', description: 'Detailed notes on TCP/IP layers and protocols', subjectId: 'sub4', subjectName: 'Computer Networks', uploadedBy: 'demo_faculty_2', uploadedByName: 'Prof. Rajesh Kumar', fileUrl: 'https://example.com/tcp_ip.pdf', fileType: 'pdf', fileSize: 4100000, uploadedAt: DateTime.now().subtract(const Duration(days: 3))),
    NoteModel(id: 'n5', title: 'ML Introduction Slides', description: 'Introduction to Machine Learning - Supervised and Unsupervised', subjectId: 'sub6', subjectName: 'Machine Learning', uploadedBy: 'demo_faculty_1', uploadedByName: 'Dr. Priya Patel', fileUrl: 'https://example.com/ml_intro.pdf', fileType: 'ppt', fileSize: 5500000, uploadedAt: DateTime.now().subtract(const Duration(days: 1))),
  ];

  // ──── Demo Results ────
  static final List<ResultModel> results = [
    ResultModel(id: 'r1', studentId: 'demo_student_1', subjectId: 'sub1', subjectName: 'Data Structures', semester: 'Semester 5', examType: 'internal', marksObtained: 38, totalMarks: 50, grade: 'A', publishedAt: DateTime.now().subtract(const Duration(days: 30))),
    ResultModel(id: 'r2', studentId: 'demo_student_1', subjectId: 'sub2', subjectName: 'Operating Systems', semester: 'Semester 5', examType: 'internal', marksObtained: 42, totalMarks: 50, grade: 'A+', publishedAt: DateTime.now().subtract(const Duration(days: 30))),
    ResultModel(id: 'r3', studentId: 'demo_student_1', subjectId: 'sub3', subjectName: 'Database Systems', semester: 'Semester 5', examType: 'internal', marksObtained: 35, totalMarks: 50, grade: 'B+', publishedAt: DateTime.now().subtract(const Duration(days: 30))),
    ResultModel(id: 'r4', studentId: 'demo_student_1', subjectId: 'sub4', subjectName: 'Computer Networks', semester: 'Semester 5', examType: 'internal', marksObtained: 28, totalMarks: 50, grade: 'B', publishedAt: DateTime.now().subtract(const Duration(days: 30))),
    ResultModel(id: 'r5', studentId: 'demo_student_1', subjectId: 'sub5', subjectName: 'Web Development Lab', semester: 'Semester 5', examType: 'internal', marksObtained: 45, totalMarks: 50, grade: 'A+', publishedAt: DateTime.now().subtract(const Duration(days: 30))),
    ResultModel(id: 'r6', studentId: 'demo_student_1', subjectId: 'sub6', subjectName: 'Machine Learning', semester: 'Semester 5', examType: 'internal', marksObtained: 40, totalMarks: 50, grade: 'A', publishedAt: DateTime.now().subtract(const Duration(days: 30))),
  ];

  // ──── Demo Events ────
  static final List<EventModel> events = [
    EventModel(id: 'e1', title: 'TechFest 2026', description: 'Annual technical festival featuring coding competitions, robotics, and innovation showcases. Open to all departments.', date: DateTime.now().add(const Duration(days: 15)), venue: 'Main Auditorium', organizer: 'CSE Department', category: 'technical', createdAt: DateTime.now()),
    EventModel(id: 'e2', title: 'Cultural Night', description: 'An evening of music, dance, and drama performances by students and guest artists.', date: DateTime.now().add(const Duration(days: 30)), venue: 'Open Air Theatre', organizer: 'Cultural Committee', category: 'cultural', createdAt: DateTime.now()),
    EventModel(id: 'e3', title: 'Sports Day', description: 'Annual inter-departmental sports competition. Events include cricket, football, basketball, and athletics.', date: DateTime.now().add(const Duration(days: 45)), venue: 'Sports Ground', organizer: 'Sports Committee', category: 'sports', createdAt: DateTime.now()),
    EventModel(id: 'e4', title: 'AI Workshop', description: 'Two-day workshop on Artificial Intelligence and Deep Learning with hands-on exercises.', date: DateTime.now().add(const Duration(days: 7)), venue: 'Seminar Hall', organizer: 'AI Club', category: 'seminar', createdAt: DateTime.now()),
  ];

  // ──── Demo Notifications ────
  static final List<NotificationModel> notifications = [
    NotificationModel(id: 'notif1', title: 'New Assignment Posted', body: 'Binary Search Tree implementation assignment has been posted for Data Structures.', type: 'assignment', createdAt: DateTime.now().subtract(const Duration(hours: 2))),
    NotificationModel(id: 'notif2', title: 'TechFest Registration Open', body: 'Register now for TechFest 2026. Last date: ${DateTime.now().add(const Duration(days: 10)).day}th.', type: 'event', createdAt: DateTime.now().subtract(const Duration(hours: 5))),
    NotificationModel(id: 'notif3', title: 'Internal Marks Published', body: 'Semester 5 internal marks have been published. Check your results.', type: 'result', createdAt: DateTime.now().subtract(const Duration(days: 1))),
    NotificationModel(id: 'notif4', title: 'Holiday Announcement', body: 'College will remain closed on Monday due to public holiday.', type: 'announcement', createdAt: DateTime.now().subtract(const Duration(days: 2))),
    NotificationModel(id: 'notif5', title: 'Library Book Return', body: 'Your borrowed book "Introduction to Algorithms" is due for return tomorrow.', type: 'general', createdAt: DateTime.now().subtract(const Duration(days: 3))),
  ];

  // ──── Demo Fees ────
  static final List<FeeModel> fees = [
    FeeModel(id: 'f1', studentId: 'demo_student_1', title: 'Tuition Fee - Sem 6', amount: 75000, paidAmount: 75000, status: 'paid', dueDate: DateTime(2026, 7, 1), paidDate: DateTime(2026, 6, 28), semester: 'Semester 6', category: 'tuition'),
    FeeModel(id: 'f2', studentId: 'demo_student_1', title: 'Exam Fee - Sem 6', amount: 3000, status: 'unpaid', dueDate: DateTime.now().add(const Duration(days: 20)), semester: 'Semester 6', category: 'exam'),
    FeeModel(id: 'f3', studentId: 'demo_student_1', title: 'Hostel Fee - Sem 6', amount: 45000, paidAmount: 22500, status: 'partial', dueDate: DateTime.now().add(const Duration(days: 10)), semester: 'Semester 6', category: 'hostel'),
    FeeModel(id: 'f4', studentId: 'demo_student_1', title: 'Library Fine', amount: 150, status: 'unpaid', dueDate: DateTime.now().add(const Duration(days: 5)), semester: 'Semester 6', category: 'library'),
  ];

  // ──── Demo Library Books ────
  static final List<LibraryBookModel> libraryBooks = [
    LibraryBookModel(id: 'b1', title: 'Introduction to Algorithms', author: 'Cormen, Leiserson, Rivest', isbn: '978-0262033848', category: 'Computer Science', totalCopies: 5, availableCopies: 2, issuedTo: 'demo_student_1', issueDate: DateTime.now().subtract(const Duration(days: 20)), returnDate: DateTime.now().add(const Duration(days: 10))),
    LibraryBookModel(id: 'b2', title: 'Operating System Concepts', author: 'Silberschatz, Galvin', isbn: '978-1118063330', category: 'Computer Science', totalCopies: 3, availableCopies: 1),
    LibraryBookModel(id: 'b3', title: 'Database System Concepts', author: 'Korth, Sudarshan', isbn: '978-0073523323', category: 'Computer Science', totalCopies: 4, availableCopies: 3),
    LibraryBookModel(id: 'b4', title: 'Computer Networking: A Top-Down Approach', author: 'Kurose, Ross', isbn: '978-0133594140', category: 'Computer Science', totalCopies: 3, availableCopies: 0, issuedTo: 'demo_student_1', issueDate: DateTime.now().subtract(const Duration(days: 35)), returnDate: DateTime.now().subtract(const Duration(days: 5)), fineAmount: 150),
    LibraryBookModel(id: 'b5', title: 'Clean Code', author: 'Robert C. Martin', isbn: '978-0132350884', category: 'Software Engineering', totalCopies: 2, availableCopies: 2),
  ];

  // ──── Demo Leave Requests ────
  static final List<LeaveRequestModel> leaveRequests = [
    LeaveRequestModel(id: 'l1', studentId: 'demo_student_1', studentName: 'Rahul Sharma', reason: 'Family function at hometown', type: 'casual', fromDate: DateTime.now().add(const Duration(days: 5)), toDate: DateTime.now().add(const Duration(days: 7)), status: 'pending', createdAt: DateTime.now()),
    LeaveRequestModel(id: 'l2', studentId: 'demo_student_1', studentName: 'Rahul Sharma', reason: 'Fever and cold', type: 'sick', fromDate: DateTime.now().subtract(const Duration(days: 10)), toDate: DateTime.now().subtract(const Duration(days: 8)), status: 'approved', approvedBy: 'Dr. Priya Patel', createdAt: DateTime.now().subtract(const Duration(days: 11))),
    LeaveRequestModel(id: 'l3', studentId: 'demo_student_1', studentName: 'Rahul Sharma', reason: 'Hackathon at IIT Delhi', type: 'od', fromDate: DateTime.now().subtract(const Duration(days: 20)), toDate: DateTime.now().subtract(const Duration(days: 18)), status: 'approved', approvedBy: 'Prof. Rajesh Kumar', createdAt: DateTime.now().subtract(const Duration(days: 22))),
  ];

  // ──── Demo Complaints ────
  static final List<ComplaintModel> complaints = [
    ComplaintModel(id: 'c1', studentId: 'demo_student_1', studentName: 'Rahul Sharma', subject: 'WiFi Connectivity Issues', description: 'The WiFi in Block C hostel has been very slow for the past week. Please look into it.', category: 'infrastructure', status: 'in_progress', createdAt: DateTime.now().subtract(const Duration(days: 3))),
    ComplaintModel(id: 'c2', studentId: 'demo_student_2', studentName: 'Ananya Gupta', subject: 'Lab Equipment Not Working', description: 'Computer #15 in Lab 2 has a broken keyboard and mouse.', category: 'infrastructure', status: 'resolved', response: 'Equipment has been replaced. Thank you for reporting.', createdAt: DateTime.now().subtract(const Duration(days: 10)), resolvedAt: DateTime.now().subtract(const Duration(days: 7))),
  ];

  // ──── Demo Departments ────
  static final List<DepartmentModel> departments = [
    const DepartmentModel(id: 'dept1', name: 'Computer Science & Engineering', hodName: 'Prof. Rajesh Kumar', description: 'Department of CSE offering B.Tech, M.Tech, and PhD programs', studentCount: 240, facultyCount: 15),
    const DepartmentModel(id: 'dept2', name: 'Electronics & Communication', hodName: 'Dr. Meena Iyer', description: 'Department of ECE with state-of-the-art labs', studentCount: 180, facultyCount: 12),
    const DepartmentModel(id: 'dept3', name: 'Mechanical Engineering', hodName: 'Prof. Sanjay Verma', description: 'Department of ME with focus on innovation', studentCount: 200, facultyCount: 14),
    const DepartmentModel(id: 'dept4', name: 'Civil Engineering', description: 'Department of CE', studentCount: 150, facultyCount: 10),
    const DepartmentModel(id: 'dept5', name: 'Electrical Engineering', description: 'Department of EE', studentCount: 160, facultyCount: 11),
  ];

  // ──── Demo Courses ────
  static final List<CourseModel> courses = [
    const CourseModel(id: 'cse', name: 'B.Tech Computer Science', departmentId: 'dept1', departmentName: 'Computer Science & Engineering', duration: 4, totalSemesters: 8),
    const CourseModel(id: 'ece', name: 'B.Tech Electronics & Communication', departmentId: 'dept2', departmentName: 'Electronics & Communication', duration: 4, totalSemesters: 8),
    const CourseModel(id: 'me', name: 'B.Tech Mechanical Engineering', departmentId: 'dept3', departmentName: 'Mechanical Engineering', duration: 4, totalSemesters: 8),
    const CourseModel(id: 'mtech_cse', name: 'M.Tech Computer Science', departmentId: 'dept1', departmentName: 'Computer Science & Engineering', duration: 2, totalSemesters: 4),
  ];

  // ──── Demo Hostels ────
  static final List<HostelModel> hostels = [
    const HostelModel(id: 'h1', name: 'Block A - Boys Hostel', type: 'boys', wardenName: 'Mr. Ramesh', wardenPhone: '9876543220', totalRooms: 100, occupiedRooms: 85),
    const HostelModel(id: 'h2', name: 'Block B - Boys Hostel', type: 'boys', wardenName: 'Mr. Suresh', wardenPhone: '9876543221', totalRooms: 100, occupiedRooms: 92),
    const HostelModel(id: 'h3', name: 'Block C - Girls Hostel', type: 'girls', wardenName: 'Mrs. Lakshmi', wardenPhone: '9876543222', totalRooms: 80, occupiedRooms: 75),
  ];

  // ──── Demo Transport ────
  static final List<TransportModel> busRoutes = [
    const TransportModel(id: 'bus1', routeNumber: 'R1', routeName: 'City Center - Campus', stops: ['City Center', 'Main Road', 'Station Road', 'Tech Park', 'Campus Gate'], driverName: 'Mr. Ravi', driverPhone: '9876543230', busNumber: 'KA-01-AB-1234', departureTime: '07:30 AM', arrivalTime: '08:30 AM'),
    const TransportModel(id: 'bus2', routeNumber: 'R2', routeName: 'Old Town - Campus', stops: ['Old Town', 'Market Road', 'Hospital Junction', 'Ring Road', 'Campus Gate'], driverName: 'Mr. Kumar', driverPhone: '9876543231', busNumber: 'KA-01-CD-5678', departureTime: '07:15 AM', arrivalTime: '08:15 AM'),
    const TransportModel(id: 'bus3', routeNumber: 'R3', routeName: 'Railway Station - Campus', stops: ['Railway Station', 'Bus Stand', 'College Road', 'Campus Gate'], driverName: 'Mr. Mahesh', driverPhone: '9876543232', busNumber: 'KA-01-EF-9012', departureTime: '07:45 AM', arrivalTime: '08:30 AM'),
  ];

  // ──── Demo Placements ────
  static final List<PlacementModel> placements = [
    PlacementModel(id: 'p1', companyName: 'Google', role: 'Software Engineer Intern', description: 'Summer internship opportunity at Google. Work on real-world projects with cutting-edge technology.', type: 'internship', package: '₹80,000/month', eligibility: 'CGPA above 8.0, CSE/ECE students', deadline: DateTime.now().add(const Duration(days: 20)), createdAt: DateTime.now()),
    PlacementModel(id: 'p2', companyName: 'Microsoft', role: 'SDE-1', description: 'Full-time Software Development Engineer position. Join the Azure team.', type: 'placement', package: '₹18 LPA', eligibility: 'CGPA above 7.5, CSE students', deadline: DateTime.now().add(const Duration(days: 30)), createdAt: DateTime.now()),
    PlacementModel(id: 'p3', companyName: 'Smart India Hackathon', role: 'Participant', description: 'National level hackathon organized by Government of India. Build innovative solutions.', type: 'hackathon', deadline: DateTime.now().add(const Duration(days: 10)), createdAt: DateTime.now()),
    PlacementModel(id: 'p4', companyName: 'NASSCOM', role: 'Data Science Training', description: '3-month training program on Data Science and Analytics with certification.', type: 'training', package: 'Free (Sponsored)', deadline: DateTime.now().add(const Duration(days: 15)), createdAt: DateTime.now()),
  ];

  // ──── Demo Emergency Contacts ────
  static const List<Map<String, String>> emergencyContacts = [
    {'name': 'Campus Security', 'phone': '1800-XXX-0001', 'icon': 'security'},
    {'name': 'Medical Emergency', 'phone': '1800-XXX-0002', 'icon': 'medical'},
    {'name': 'Fire Station', 'phone': '101', 'icon': 'fire'},
    {'name': 'Police', 'phone': '100', 'icon': 'police'},
    {'name': 'Ambulance', 'phone': '108', 'icon': 'ambulance'},
    {'name': 'Women Helpline', 'phone': '181', 'icon': 'women'},
    {'name': 'Anti-Ragging Cell', 'phone': '1800-XXX-0003', 'icon': 'ragging'},
    {'name': 'Dean of Students', 'phone': '9876543200', 'icon': 'dean'},
  ];
}
