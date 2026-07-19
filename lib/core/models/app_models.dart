/// All data models for E-Campus
library;

import 'package:cloud_firestore/cloud_firestore.dart';

// ══════════════════════════════════════════════
// Attendance Model
// ══════════════════════════════════════════════
class AttendanceModel {
  final String id;
  final String studentId;
  final String subjectId;
  final String subjectName;
  final DateTime date;
  final String status; // present, absent, late
  final String? markedBy;

  const AttendanceModel({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.subjectName,
    required this.date,
    required this.status,
    this.markedBy,
  });

  factory AttendanceModel.fromMap(Map<String, dynamic> map, String docId) {
    return AttendanceModel(
      id: docId,
      studentId: map['studentId'] ?? '',
      subjectId: map['subjectId'] ?? '',
      subjectName: map['subjectName'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      status: map['status'] ?? 'absent',
      markedBy: map['markedBy'],
    );
  }

  Map<String, dynamic> toMap() => {
        'studentId': studentId,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'date': Timestamp.fromDate(date),
        'status': status,
        'markedBy': markedBy,
      };
}

// ══════════════════════════════════════════════
// Subject Model
// ══════════════════════════════════════════════
class SubjectModel {
  final String id;
  final String name;
  final String code;
  final String courseId;
  final String? facultyId;
  final String? facultyName;
  final int credits;
  final String type; // theory, practical, elective

  const SubjectModel({
    required this.id,
    required this.name,
    required this.code,
    required this.courseId,
    this.facultyId,
    this.facultyName,
    this.credits = 3,
    this.type = 'theory',
  });

  factory SubjectModel.fromMap(Map<String, dynamic> map, String docId) {
    return SubjectModel(
      id: docId,
      name: map['name'] ?? '',
      code: map['code'] ?? '',
      courseId: map['courseId'] ?? '',
      facultyId: map['facultyId'],
      facultyName: map['facultyName'],
      credits: map['credits'] ?? 3,
      type: map['type'] ?? 'theory',
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'code': code,
        'courseId': courseId,
        'facultyId': facultyId,
        'facultyName': facultyName,
        'credits': credits,
        'type': type,
      };
}

// ══════════════════════════════════════════════
// Assignment Model
// ══════════════════════════════════════════════
class AssignmentModel {
  final String id;
  final String title;
  final String description;
  final String subjectId;
  final String subjectName;
  final String assignedBy;
  final String? fileUrl;
  final DateTime dueDate;
  final DateTime createdAt;
  final String status; // active, closed
  final int totalMarks;

  const AssignmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectId,
    required this.subjectName,
    required this.assignedBy,
    this.fileUrl,
    required this.dueDate,
    required this.createdAt,
    this.status = 'active',
    this.totalMarks = 10,
  });

  factory AssignmentModel.fromMap(Map<String, dynamic> map, String docId) {
    return AssignmentModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subjectId: map['subjectId'] ?? '',
      subjectName: map['subjectName'] ?? '',
      assignedBy: map['assignedBy'] ?? '',
      fileUrl: map['fileUrl'],
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      status: map['status'] ?? 'active',
      totalMarks: map['totalMarks'] ?? 10,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'assignedBy': assignedBy,
        'fileUrl': fileUrl,
        'dueDate': Timestamp.fromDate(dueDate),
        'createdAt': Timestamp.fromDate(createdAt),
        'status': status,
        'totalMarks': totalMarks,
      };

  bool get isOverdue => DateTime.now().isAfter(dueDate) && status == 'active';
}

// ══════════════════════════════════════════════
// Assignment Submission Model
// ══════════════════════════════════════════════
class SubmissionModel {
  final String id;
  final String assignmentId;
  final String studentId;
  final String studentName;
  final String? fileUrl;
  final String? comment;
  final DateTime submittedAt;
  final int? marks;
  final String? feedback;
  final String status; // submitted, graded, late

  const SubmissionModel({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.studentName,
    this.fileUrl,
    this.comment,
    required this.submittedAt,
    this.marks,
    this.feedback,
    this.status = 'submitted',
  });

  factory SubmissionModel.fromMap(Map<String, dynamic> map, String docId) {
    return SubmissionModel(
      id: docId,
      assignmentId: map['assignmentId'] ?? '',
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      fileUrl: map['fileUrl'],
      comment: map['comment'],
      submittedAt: (map['submittedAt'] as Timestamp).toDate(),
      marks: map['marks'],
      feedback: map['feedback'],
      status: map['status'] ?? 'submitted',
    );
  }

  Map<String, dynamic> toMap() => {
        'assignmentId': assignmentId,
        'studentId': studentId,
        'studentName': studentName,
        'fileUrl': fileUrl,
        'comment': comment,
        'submittedAt': Timestamp.fromDate(submittedAt),
        'marks': marks,
        'feedback': feedback,
        'status': status,
      };
}

// ══════════════════════════════════════════════
// Notes Model
// ══════════════════════════════════════════════
class NoteModel {
  final String id;
  final String title;
  final String description;
  final String subjectId;
  final String subjectName;
  final String uploadedBy;
  final String uploadedByName;
  final String fileUrl;
  final String fileType; // pdf, doc, ppt, etc.
  final int fileSize;
  final DateTime uploadedAt;

  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectId,
    required this.subjectName,
    required this.uploadedBy,
    required this.uploadedByName,
    required this.fileUrl,
    this.fileType = 'pdf',
    this.fileSize = 0,
    required this.uploadedAt,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map, String docId) {
    return NoteModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subjectId: map['subjectId'] ?? '',
      subjectName: map['subjectName'] ?? '',
      uploadedBy: map['uploadedBy'] ?? '',
      uploadedByName: map['uploadedByName'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      fileType: map['fileType'] ?? 'pdf',
      fileSize: map['fileSize'] ?? 0,
      uploadedAt: (map['uploadedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'uploadedBy': uploadedBy,
        'uploadedByName': uploadedByName,
        'fileUrl': fileUrl,
        'fileType': fileType,
        'fileSize': fileSize,
        'uploadedAt': Timestamp.fromDate(uploadedAt),
      };

  String get fileSizeFormatted {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

// ══════════════════════════════════════════════
// Result Model
// ══════════════════════════════════════════════
class ResultModel {
  final String id;
  final String studentId;
  final String subjectId;
  final String subjectName;
  final String semester;
  final String examType; // internal, external, midterm
  final int marksObtained;
  final int totalMarks;
  final String? grade;
  final DateTime publishedAt;

  const ResultModel({
    required this.id,
    required this.studentId,
    required this.subjectId,
    required this.subjectName,
    required this.semester,
    required this.examType,
    required this.marksObtained,
    required this.totalMarks,
    this.grade,
    required this.publishedAt,
  });

  factory ResultModel.fromMap(Map<String, dynamic> map, String docId) {
    return ResultModel(
      id: docId,
      studentId: map['studentId'] ?? '',
      subjectId: map['subjectId'] ?? '',
      subjectName: map['subjectName'] ?? '',
      semester: map['semester'] ?? '',
      examType: map['examType'] ?? 'internal',
      marksObtained: map['marksObtained'] ?? 0,
      totalMarks: map['totalMarks'] ?? 100,
      grade: map['grade'],
      publishedAt: (map['publishedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'studentId': studentId,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'semester': semester,
        'examType': examType,
        'marksObtained': marksObtained,
        'totalMarks': totalMarks,
        'grade': grade,
        'publishedAt': Timestamp.fromDate(publishedAt),
      };

  double get percentage => (marksObtained / totalMarks) * 100;
}

// ══════════════════════════════════════════════
// Event Model
// ══════════════════════════════════════════════
class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime date;
  final String? venue;
  final String? organizer;
  final String category; // cultural, technical, sports, seminar
  final DateTime createdAt;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.date,
    this.venue,
    this.organizer,
    this.category = 'general',
    required this.createdAt,
  });

  factory EventModel.fromMap(Map<String, dynamic> map, String docId) {
    return EventModel(
      id: docId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      date: (map['date'] as Timestamp).toDate(),
      venue: map['venue'],
      organizer: map['organizer'],
      category: map['category'] ?? 'general',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'date': Timestamp.fromDate(date),
        'venue': venue,
        'organizer': organizer,
        'category': category,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  bool get isUpcoming => date.isAfter(DateTime.now());
}

// ══════════════════════════════════════════════
// Notification Model
// ══════════════════════════════════════════════
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type; // announcement, event, assignment, result, general
  final String? targetRole; // student, faculty, admin, all
  final String? imageUrl;
  final DateTime createdAt;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.type = 'general',
    this.targetRole,
    this.imageUrl,
    required this.createdAt,
    this.isRead = false,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, String docId) {
    return NotificationModel(
      id: docId,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      type: map['type'] ?? 'general',
      targetRole: map['targetRole'],
      imageUrl: map['imageUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isRead: map['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'body': body,
        'type': type,
        'targetRole': targetRole,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
        'isRead': isRead,
      };
}

// ══════════════════════════════════════════════
// Fee Model
// ══════════════════════════════════════════════
class FeeModel {
  final String id;
  final String studentId;
  final String title;
  final double amount;
  final double? paidAmount;
  final String status; // paid, unpaid, partial
  final DateTime dueDate;
  final DateTime? paidDate;
  final String semester;
  final String category; // tuition, hostel, transport, exam, library

  const FeeModel({
    required this.id,
    required this.studentId,
    required this.title,
    required this.amount,
    this.paidAmount,
    this.status = 'unpaid',
    required this.dueDate,
    this.paidDate,
    required this.semester,
    this.category = 'tuition',
  });

  factory FeeModel.fromMap(Map<String, dynamic> map, String docId) {
    return FeeModel(
      id: docId,
      studentId: map['studentId'] ?? '',
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      paidAmount: map['paidAmount']?.toDouble(),
      status: map['status'] ?? 'unpaid',
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      paidDate:
          map['paidDate'] != null ? (map['paidDate'] as Timestamp).toDate() : null,
      semester: map['semester'] ?? '',
      category: map['category'] ?? 'tuition',
    );
  }

  Map<String, dynamic> toMap() => {
        'studentId': studentId,
        'title': title,
        'amount': amount,
        'paidAmount': paidAmount,
        'status': status,
        'dueDate': Timestamp.fromDate(dueDate),
        'paidDate': paidDate != null ? Timestamp.fromDate(paidDate!) : null,
        'semester': semester,
        'category': category,
      };

  double get pendingAmount => amount - (paidAmount ?? 0);
}

// ══════════════════════════════════════════════
// Library Book Model
// ══════════════════════════════════════════════
class LibraryBookModel {
  final String id;
  final String title;
  final String author;
  final String isbn;
  final String category;
  final int totalCopies;
  final int availableCopies;
  final String? imageUrl;
  final String? issuedTo;
  final DateTime? issueDate;
  final DateTime? returnDate;
  final double? fineAmount;

  const LibraryBookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.isbn,
    this.category = 'General',
    this.totalCopies = 1,
    this.availableCopies = 1,
    this.imageUrl,
    this.issuedTo,
    this.issueDate,
    this.returnDate,
    this.fineAmount,
  });

  factory LibraryBookModel.fromMap(Map<String, dynamic> map, String docId) {
    return LibraryBookModel(
      id: docId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      isbn: map['isbn'] ?? '',
      category: map['category'] ?? 'General',
      totalCopies: map['totalCopies'] ?? 1,
      availableCopies: map['availableCopies'] ?? 1,
      imageUrl: map['imageUrl'],
      issuedTo: map['issuedTo'],
      issueDate:
          map['issueDate'] != null ? (map['issueDate'] as Timestamp).toDate() : null,
      returnDate: map['returnDate'] != null
          ? (map['returnDate'] as Timestamp).toDate()
          : null,
      fineAmount: map['fineAmount']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'author': author,
        'isbn': isbn,
        'category': category,
        'totalCopies': totalCopies,
        'availableCopies': availableCopies,
        'imageUrl': imageUrl,
        'issuedTo': issuedTo,
        'issueDate':
            issueDate != null ? Timestamp.fromDate(issueDate!) : null,
        'returnDate':
            returnDate != null ? Timestamp.fromDate(returnDate!) : null,
        'fineAmount': fineAmount,
      };

  bool get isOverdue =>
      returnDate != null && DateTime.now().isAfter(returnDate!);
}

// ══════════════════════════════════════════════
// Complaint Model
// ══════════════════════════════════════════════
class ComplaintModel {
  final String id;
  final String studentId;
  final String studentName;
  final String subject;
  final String description;
  final String category; // academic, hostel, infrastructure, other
  final String status; // pending, in_progress, resolved, rejected
  final String? response;
  final DateTime createdAt;
  final DateTime? resolvedAt;

  const ComplaintModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.subject,
    required this.description,
    this.category = 'other',
    this.status = 'pending',
    this.response,
    required this.createdAt,
    this.resolvedAt,
  });

  factory ComplaintModel.fromMap(Map<String, dynamic> map, String docId) {
    return ComplaintModel(
      id: docId,
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      subject: map['subject'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? 'other',
      status: map['status'] ?? 'pending',
      response: map['response'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      resolvedAt: map['resolvedAt'] != null
          ? (map['resolvedAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'studentId': studentId,
        'studentName': studentName,
        'subject': subject,
        'description': description,
        'category': category,
        'status': status,
        'response': response,
        'createdAt': Timestamp.fromDate(createdAt),
        'resolvedAt':
            resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
      };
}

// ══════════════════════════════════════════════
// Leave Request Model
// ══════════════════════════════════════════════
class LeaveRequestModel {
  final String id;
  final String studentId;
  final String studentName;
  final String reason;
  final String type; // sick, casual, od, emergency
  final DateTime fromDate;
  final DateTime toDate;
  final String status; // pending, approved, rejected
  final String? approvedBy;
  final String? remarks;
  final DateTime createdAt;

  const LeaveRequestModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.reason,
    this.type = 'casual',
    required this.fromDate,
    required this.toDate,
    this.status = 'pending',
    this.approvedBy,
    this.remarks,
    required this.createdAt,
  });

  factory LeaveRequestModel.fromMap(Map<String, dynamic> map, String docId) {
    return LeaveRequestModel(
      id: docId,
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      reason: map['reason'] ?? '',
      type: map['type'] ?? 'casual',
      fromDate: (map['fromDate'] as Timestamp).toDate(),
      toDate: (map['toDate'] as Timestamp).toDate(),
      status: map['status'] ?? 'pending',
      approvedBy: map['approvedBy'],
      remarks: map['remarks'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'studentId': studentId,
        'studentName': studentName,
        'reason': reason,
        'type': type,
        'fromDate': Timestamp.fromDate(fromDate),
        'toDate': Timestamp.fromDate(toDate),
        'status': status,
        'approvedBy': approvedBy,
        'remarks': remarks,
        'createdAt': Timestamp.fromDate(createdAt),
      };

  int get totalDays => toDate.difference(fromDate).inDays + 1;
}

// ══════════════════════════════════════════════
// Chat Room & Message Models
// ══════════════════════════════════════════════
class ChatRoomModel {
  final String id;
  final List<String> participants;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final String? lastMessageSenderId;

  const ChatRoomModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageSenderId,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map, String docId) {
    return ChatRoomModel(
      id: docId,
      participants: List<String>.from(map['participants'] ?? []),
      lastMessage: map['lastMessage'],
      lastMessageTime: map['lastMessageTime'] != null
          ? (map['lastMessageTime'] as Timestamp).toDate()
          : null,
      lastMessageSenderId: map['lastMessageSenderId'],
    );
  }

  Map<String, dynamic> toMap() => {
        'participants': participants,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime != null
            ? Timestamp.fromDate(lastMessageTime!)
            : null,
        'lastMessageSenderId': lastMessageSenderId,
      };
}

class ChatMessageModel {
  final String id;
  final String roomId;
  final String senderId;
  final String senderName;
  final String text;
  final String type; // text, image, file
  final String? fileUrl;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderName,
    required this.text,
    this.type = 'text',
    this.fileUrl,
    required this.timestamp,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map, String docId) {
    return ChatMessageModel(
      id: docId,
      roomId: map['roomId'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      text: map['text'] ?? '',
      type: map['type'] ?? 'text',
      fileUrl: map['fileUrl'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'roomId': roomId,
        'senderId': senderId,
        'senderName': senderName,
        'text': text,
        'type': type,
        'fileUrl': fileUrl,
        'timestamp': Timestamp.fromDate(timestamp),
      };
}

// ══════════════════════════════════════════════
// Department & Course Models
// ══════════════════════════════════════════════
class DepartmentModel {
  final String id;
  final String name;
  final String? hodId;
  final String? hodName;
  final String? description;
  final int studentCount;
  final int facultyCount;

  const DepartmentModel({
    required this.id,
    required this.name,
    this.hodId,
    this.hodName,
    this.description,
    this.studentCount = 0,
    this.facultyCount = 0,
  });

  factory DepartmentModel.fromMap(Map<String, dynamic> map, String docId) {
    return DepartmentModel(
      id: docId,
      name: map['name'] ?? '',
      hodId: map['hodId'],
      hodName: map['hodName'],
      description: map['description'],
      studentCount: map['studentCount'] ?? 0,
      facultyCount: map['facultyCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'hodId': hodId,
        'hodName': hodName,
        'description': description,
        'studentCount': studentCount,
        'facultyCount': facultyCount,
      };
}

class CourseModel {
  final String id;
  final String name;
  final String departmentId;
  final String? departmentName;
  final int duration; // years
  final int totalSemesters;

  const CourseModel({
    required this.id,
    required this.name,
    required this.departmentId,
    this.departmentName,
    this.duration = 4,
    this.totalSemesters = 8,
  });

  factory CourseModel.fromMap(Map<String, dynamic> map, String docId) {
    return CourseModel(
      id: docId,
      name: map['name'] ?? '',
      departmentId: map['departmentId'] ?? '',
      departmentName: map['departmentName'],
      duration: map['duration'] ?? 4,
      totalSemesters: map['totalSemesters'] ?? 8,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'departmentId': departmentId,
        'departmentName': departmentName,
        'duration': duration,
        'totalSemesters': totalSemesters,
      };
}

// ══════════════════════════════════════════════
// Timetable Model
// ══════════════════════════════════════════════
class TimetableEntry {
  final String id;
  final String courseId;
  final String day; // Monday, Tuesday, etc.
  final int period; // 1-8
  final String startTime;
  final String endTime;
  final String subjectId;
  final String subjectName;
  final String? facultyName;
  final String? room;

  const TimetableEntry({
    required this.id,
    required this.courseId,
    required this.day,
    required this.period,
    required this.startTime,
    required this.endTime,
    required this.subjectId,
    required this.subjectName,
    this.facultyName,
    this.room,
  });

  factory TimetableEntry.fromMap(Map<String, dynamic> map, String docId) {
    return TimetableEntry(
      id: docId,
      courseId: map['courseId'] ?? '',
      day: map['day'] ?? '',
      period: map['period'] ?? 1,
      startTime: map['startTime'] ?? '',
      endTime: map['endTime'] ?? '',
      subjectId: map['subjectId'] ?? '',
      subjectName: map['subjectName'] ?? '',
      facultyName: map['facultyName'],
      room: map['room'],
    );
  }

  Map<String, dynamic> toMap() => {
        'courseId': courseId,
        'day': day,
        'period': period,
        'startTime': startTime,
        'endTime': endTime,
        'subjectId': subjectId,
        'subjectName': subjectName,
        'facultyName': facultyName,
        'room': room,
      };
}

// ══════════════════════════════════════════════
// Hostel & Transport Models
// ══════════════════════════════════════════════
class HostelModel {
  final String id;
  final String name;
  final String type; // boys, girls
  final String? wardenName;
  final String? wardenPhone;
  final int totalRooms;
  final int occupiedRooms;
  final String? address;

  const HostelModel({
    required this.id,
    required this.name,
    this.type = 'boys',
    this.wardenName,
    this.wardenPhone,
    this.totalRooms = 0,
    this.occupiedRooms = 0,
    this.address,
  });

  factory HostelModel.fromMap(Map<String, dynamic> map, String docId) {
    return HostelModel(
      id: docId,
      name: map['name'] ?? '',
      type: map['type'] ?? 'boys',
      wardenName: map['wardenName'],
      wardenPhone: map['wardenPhone'],
      totalRooms: map['totalRooms'] ?? 0,
      occupiedRooms: map['occupiedRooms'] ?? 0,
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        'wardenName': wardenName,
        'wardenPhone': wardenPhone,
        'totalRooms': totalRooms,
        'occupiedRooms': occupiedRooms,
        'address': address,
      };
}

class TransportModel {
  final String id;
  final String routeNumber;
  final String routeName;
  final List<String> stops;
  final String driverName;
  final String driverPhone;
  final String? busNumber;
  final String departureTime;
  final String arrivalTime;

  const TransportModel({
    required this.id,
    required this.routeNumber,
    required this.routeName,
    required this.stops,
    required this.driverName,
    required this.driverPhone,
    this.busNumber,
    required this.departureTime,
    required this.arrivalTime,
  });

  factory TransportModel.fromMap(Map<String, dynamic> map, String docId) {
    return TransportModel(
      id: docId,
      routeNumber: map['routeNumber'] ?? '',
      routeName: map['routeName'] ?? '',
      stops: List<String>.from(map['stops'] ?? []),
      driverName: map['driverName'] ?? '',
      driverPhone: map['driverPhone'] ?? '',
      busNumber: map['busNumber'],
      departureTime: map['departureTime'] ?? '',
      arrivalTime: map['arrivalTime'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'routeNumber': routeNumber,
        'routeName': routeName,
        'stops': stops,
        'driverName': driverName,
        'driverPhone': driverPhone,
        'busNumber': busNumber,
        'departureTime': departureTime,
        'arrivalTime': arrivalTime,
      };
}

// ══════════════════════════════════════════════
// Placement Model
// ══════════════════════════════════════════════
class PlacementModel {
  final String id;
  final String companyName;
  final String role;
  final String description;
  final String type; // placement, internship, hackathon, training
  final String? package;
  final String? eligibility;
  final DateTime deadline;
  final String? applyLink;
  final String? imageUrl;
  final DateTime createdAt;

  const PlacementModel({
    required this.id,
    required this.companyName,
    required this.role,
    required this.description,
    this.type = 'placement',
    this.package,
    this.eligibility,
    required this.deadline,
    this.applyLink,
    this.imageUrl,
    required this.createdAt,
  });

  factory PlacementModel.fromMap(Map<String, dynamic> map, String docId) {
    return PlacementModel(
      id: docId,
      companyName: map['companyName'] ?? '',
      role: map['role'] ?? '',
      description: map['description'] ?? '',
      type: map['type'] ?? 'placement',
      package: map['package'],
      eligibility: map['eligibility'],
      deadline: (map['deadline'] as Timestamp).toDate(),
      applyLink: map['applyLink'],
      imageUrl: map['imageUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'companyName': companyName,
        'role': role,
        'description': description,
        'type': type,
        'package': package,
        'eligibility': eligibility,
        'deadline': Timestamp.fromDate(deadline),
        'applyLink': applyLink,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}

// ══════════════════════════════════════════════
// Feedback Model
// ══════════════════════════════════════════════
class FeedbackModel {
  final String id;
  final String studentId;
  final String studentName;
  final String subject;
  final String message;
  final int rating; // 1-5
  final String category; // faculty, infrastructure, canteen, library, other
  final DateTime createdAt;

  const FeedbackModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.subject,
    required this.message,
    required this.rating,
    this.category = 'other',
    required this.createdAt,
  });

  factory FeedbackModel.fromMap(Map<String, dynamic> map, String docId) {
    return FeedbackModel(
      id: docId,
      studentId: map['studentId'] ?? '',
      studentName: map['studentName'] ?? '',
      subject: map['subject'] ?? '',
      message: map['message'] ?? '',
      rating: map['rating'] ?? 3,
      category: map['category'] ?? 'other',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() => {
        'studentId': studentId,
        'studentName': studentName,
        'subject': subject,
        'message': message,
        'rating': rating,
        'category': category,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
