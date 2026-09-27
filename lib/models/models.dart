enum UserRole { student, teacher, admin }

enum RecordStatus { pending, submitted, graded, overdue }

class Course {
  final String id;
  final String name;
  final String code;
  final String instructor;
  final String room;
  final String nextClass;
  final int completed;
  final int total;
  final int attendance;

  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.instructor,
    required this.room,
    required this.nextClass,
    required this.completed,
    required this.total,
    required this.attendance,
  });

  double get progress => total == 0 ? 0 : completed / total;
}

class Assignment {
  final String id;
  final String courseId;
  final String title;
  final DateTime due;
  final int marks;
  final RecordStatus status;

  const Assignment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.due,
    required this.marks,
    required this.status,
  });

  Assignment copyWith({RecordStatus? status}) {
    return Assignment(
      id: id,
      courseId: courseId,
      title: title,
      due: due,
      marks: marks,
      status: status ?? this.status,
    );
  }
}

class Announcement {
  final String title;
  final String message;
  final String age;

  const Announcement({
    required this.title,
    required this.message,
    required this.age,
  });
}

class CalendarEvent {
  final String title;
  final DateTime date;
  final String time;
  final String category;

  const CalendarEvent({
    required this.title,
    required this.date,
    required this.time,
    required this.category,
  });
}

class AttendancePoint {
  final String label;
  final double value;

  const AttendancePoint(this.label, this.value);
}

class ServiceRequest {
  final String id;
  final String title;
  final String category;
  final String status;
  final String date;

  ServiceRequest({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.date,
  });
}
