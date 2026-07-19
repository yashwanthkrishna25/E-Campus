/// User model supporting Student, Faculty, and Admin roles
library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_campus/core/constants/app_constants.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final UserRole role;
  final String? phone;
  final String? profileImageUrl;
  final String? department;
  final String? course;
  final String? semester;
  final String? rollNumber;
  final String? employeeId;
  final String? designation;
  final String? bio;
  final String? address;
  final DateTime? dateOfBirth;
  final DateTime createdAt;
  final bool isActive;
  final bool isProfileComplete;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.profileImageUrl,
    this.department,
    this.course,
    this.semester,
    this.rollNumber,
    this.employeeId,
    this.designation,
    this.bio,
    this.address,
    this.dateOfBirth,
    required this.createdAt,
    this.isActive = true,
    this.isProfileComplete = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      role: UserRole.values.firstWhere(
        (r) => r.name == map['role'],
        orElse: () => UserRole.student,
      ),
      phone: map['phone'] as String?,
      profileImageUrl: map['profileImageUrl'] as String?,
      department: map['department'] as String?,
      course: map['course'] as String?,
      semester: map['semester'] as String?,
      rollNumber: map['rollNumber'] as String?,
      employeeId: map['employeeId'] as String?,
      designation: map['designation'] as String?,
      bio: map['bio'] as String?,
      address: map['address'] as String?,
      dateOfBirth: map['dateOfBirth'] != null
          ? (map['dateOfBirth'] as Timestamp).toDate()
          : null,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isActive: map['isActive'] as bool? ?? true,
      isProfileComplete: map['isProfileComplete'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role.name,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'department': department,
      'course': course,
      'semester': semester,
      'rollNumber': rollNumber,
      'employeeId': employeeId,
      'designation': designation,
      'bio': bio,
      'address': address,
      'dateOfBirth': dateOfBirth != null ? Timestamp.fromDate(dateOfBirth!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'isActive': isActive,
      'isProfileComplete': isProfileComplete,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    UserRole? role,
    String? phone,
    String? profileImageUrl,
    String? department,
    String? course,
    String? semester,
    String? rollNumber,
    String? employeeId,
    String? designation,
    String? bio,
    String? address,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    bool? isActive,
    bool? isProfileComplete,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      department: department ?? this.department,
      course: course ?? this.course,
      semester: semester ?? this.semester,
      rollNumber: rollNumber ?? this.rollNumber,
      employeeId: employeeId ?? this.employeeId,
      designation: designation ?? this.designation,
      bio: bio ?? this.bio,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }

  /// Create a demo student user
  static UserModel demoStudent() => UserModel(
        uid: 'demo_student_1',
        name: 'Rahul Sharma',
        email: 'rahul@ecampus.com',
        role: UserRole.student,
        phone: '9876543210',
        department: 'Computer Science',
        course: 'B.Tech CSE',
        semester: 'Semester 6',
        rollNumber: '20CS101',
        bio: 'Passionate about coding and technology',
        createdAt: DateTime(2024, 1, 1),
        isActive: true,
        isProfileComplete: true,
      );

  /// Create a demo faculty user
  static UserModel demoFaculty() => UserModel(
        uid: 'demo_faculty_1',
        name: 'Dr. Priya Patel',
        email: 'priya@ecampus.com',
        role: UserRole.faculty,
        phone: '9876543211',
        department: 'Computer Science',
        employeeId: 'FAC001',
        designation: 'Associate Professor',
        bio: 'PhD in Machine Learning with 10 years of experience',
        createdAt: DateTime(2023, 6, 1),
        isActive: true,
        isProfileComplete: true,
      );

  /// Create a demo admin user
  static UserModel demoAdmin() => UserModel(
        uid: 'demo_admin_1',
        name: 'Admin User',
        email: 'admin@ecampus.com',
        role: UserRole.admin,
        phone: '9876543212',
        department: 'Administration',
        employeeId: 'ADM001',
        designation: 'System Administrator',
        createdAt: DateTime(2023, 1, 1),
        isActive: true,
        isProfileComplete: true,
      );
}
