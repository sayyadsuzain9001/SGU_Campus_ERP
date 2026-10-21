import '../models/models.dart';

class MockData {
  MockData._();
  static final MockData i = MockData._();

  String studentName = 'Suzain Mudabbir Sayyad';
  String studentId = 'I26043300';
  String programme = 'B.Tech Artificial Intelligence & Machine Learning';
  String email = 'suzain@example.edu';
  String semester = 'Semester 6';
  double cgpa = 8.35;
  int overallAttendance = 82;
  int credits = 96;

  final List<Course> courses = const [
    Course(id: 'ml', name: 'Machine Learning', code: 'PRG4206', instructor: 'Dr. A. Patil', room: 'Room 305', nextClass: 'Today • 11:30 AM', completed: 3, total: 5, attendance: 84),
    Course(id: 'dl', name: 'Deep Learning', code: 'PRG4207', instructor: 'Dr. R. Kulkarni', room: 'Lab 204', nextClass: 'Tomorrow • 09:00 AM', completed: 2, total: 6, attendance: 83),
    Course(id: 'mobile', name: 'Cross-Platform Mobile Application', code: 'NET4207', instructor: 'Prof. S. Joshi', room: 'Lab 101', nextClass: 'Today • 10:00 AM', completed: 1, total: 5, attendance: 88),
    Course(id: 'cv', name: 'Computer Vision', code: 'AIML4204', instructor: 'Dr. P. Deshmukh', room: 'Lab 101', nextClass: 'Friday • 02:00 PM', completed: 1, total: 5, attendance: 86),
  ];

  List<Assignment> assignments = [
    Assignment(id: 'a1', courseId: 'dl', title: 'Deep Learning Assignment', due: DateTime(2026, 9, 25, 23, 59), marks: 20, status: RecordStatus.pending),
    Assignment(id: 'a2', courseId: 'ml', title: 'Machine Learning Report', due: DateTime(2026, 9, 29, 23, 59), marks: 30, status: RecordStatus.pending),
    Assignment(id: 'a3', courseId: 'mobile', title: 'Mobile Application Prototype', due: DateTime(2026, 10, 2, 23, 59), marks: 25, status: RecordStatus.submitted),
  ];

  List<ServiceRequest> requests = [
    ServiceRequest(id: 'r1', title: 'Official Transcript Request', category: 'Academic', status: 'In Progress', date: '24 Sep 2026'),
    ServiceRequest(id: 'r2', title: 'Hostel Outpass Application', category: 'Facilities', status: 'Approved', date: '22 Sep 2026'),
  ];

  final List<Announcement> announcements = const [
    Announcement(title: 'Assignment Deadline Reminder', message: 'Deep Learning assignment due on 25 Sep.', age: '2 hours ago'),
    Announcement(title: 'Lab Session Update', message: 'Lab 204 will be available for the session.', age: '1 day ago'),
    Announcement(title: 'Mid-Semester Examination', message: 'Schedule has been released. Check calendar.', age: '2 days ago'),
  ];

  final List<CalendarEvent> events = [
    CalendarEvent(title: 'Week 4 Lab', date: DateTime(2026, 9, 24), time: '02:00 PM', category: 'Events'),
    CalendarEvent(title: 'Machine Learning - Data Mining', date: DateTime(2026, 9, 24), time: '11:30 AM', category: 'Classes'),
    CalendarEvent(title: 'Deep Learning Assignment', date: DateTime(2026, 9, 25), time: '11:59 PM', category: 'Deadlines'),
    CalendarEvent(title: 'Mid-Semester Review', date: DateTime(2026, 9, 30), time: '02:00 PM', category: 'Events'),
  ];

  final List<AttendancePoint> attendanceTrend = const [
    AttendancePoint('Mon', .78), AttendancePoint('Tue', .80), AttendancePoint('Wed', .79),
    AttendancePoint('Thu', .82), AttendancePoint('Fri', .81), AttendancePoint('Sat', .82),
  ];

  Course course(String id) => courses.firstWhere((item) => item.id == id, orElse: () => courses.first);
}
