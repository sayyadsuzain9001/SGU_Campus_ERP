import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

import '../screens/student/student_dashboard.dart';
import '../screens/student/student_courses.dart';
import '../screens/student/student_assignments.dart';
import '../screens/student/student_attendance.dart';
import '../screens/student/student_timetable.dart';
import '../screens/student/student_progress.dart';
import '../screens/student/student_registration.dart';
import '../screens/student/student_exams.dart';
import '../screens/student/student_hall_ticket.dart';
import '../screens/student/student_results.dart';
import '../screens/student/student_transcript.dart';
import '../screens/student/student_calendar.dart';
import '../screens/student/student_events.dart';
import '../screens/student/student_clubs.dart';
import '../screens/student/student_library.dart';
import '../screens/student/student_hostel.dart';
import '../screens/student/student_transport.dart';
import '../screens/student/student_cafeteria.dart';
import '../screens/student/student_finance.dart';
import '../screens/student/student_documents.dart';
import '../screens/student/student_career.dart';
import '../screens/student/student_notifications.dart';
import '../screens/student/student_tasks.dart';
import '../screens/student/student_messages.dart';
import '../screens/student/student_requests.dart';
import '../screens/student/student_profile.dart';
import '../screens/student/student_settings.dart';
import '../screens/student/student_help_support.dart';

import '../screens/teacher/teacher_dashboard.dart';
import '../screens/teacher/teacher_courses.dart';
import '../screens/teacher/teacher_assignments.dart';
import '../screens/teacher/teacher_submissions.dart';
import '../screens/teacher/teacher_grading.dart';
import '../screens/teacher/teacher_attendance.dart';
import '../screens/teacher/teacher_students.dart';
import '../screens/teacher/teacher_materials.dart';
import '../screens/teacher/teacher_calendar.dart';
import '../screens/teacher/teacher_analytics.dart';
import '../screens/teacher/teacher_profile.dart';
import '../screens/teacher/teacher_settings.dart';
import '../screens/teacher/teacher_help_support.dart';

import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/admin_students.dart';
import '../screens/admin/admin_teachers.dart';
import '../screens/admin/admin_staff.dart';
import '../screens/admin/admin_courses.dart';
import '../screens/admin/admin_departments.dart';
import '../screens/admin/admin_programmes.dart';
import '../screens/admin/admin_subjects.dart';
import '../screens/admin/admin_timetable.dart';
import '../screens/admin/admin_exams.dart';
import '../screens/admin/admin_academic_calendar.dart';
import '../screens/admin/admin_assignments.dart';
import '../screens/admin/admin_submissions.dart';
import '../screens/admin/admin_grades.dart';
import '../screens/admin/admin_attendance.dart';
import '../screens/admin/admin_announcements.dart';
import '../screens/admin/admin_events.dart';
import '../screens/admin/admin_facilities.dart';
import '../screens/admin/admin_finance.dart';
import '../screens/admin/admin_requests.dart';
import '../screens/admin/admin_reports.dart';
import '../screens/admin/admin_notifications.dart';
import '../screens/admin/admin_audit_logs.dart';
import '../screens/admin/admin_settings.dart';
import '../screens/admin/admin_help_support.dart';

import '../screens/shared/course_workspace.dart';
import '../screens/shared/module_pages.dart';
import '../screens/shared/notifications.dart';
import '../screens/shared/messages.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  UserRole role = UserRole.student;

  String selected = 'Dashboard';

  // Controls whether the desktop/web sidebar is visible.
  bool desktopSidebarVisible = true;

  List<NavItem> get navItems {
    switch (role) {
      case UserRole.student:
        return const [
          NavItem('Dashboard', Icons.dashboard_outlined),
          NavItem('My Courses', Icons.menu_book_outlined),
          NavItem('Assignments', Icons.assignment_outlined),
          NavItem('Attendance', Icons.fact_check_outlined),
          NavItem('Timetable', Icons.schedule_outlined),
          NavItem('Academic Progress', Icons.trending_up_outlined),
          NavItem('Course Registration', Icons.app_registration_outlined),
          NavItem('Exam Schedule', Icons.event_note_outlined),
          NavItem('Hall Ticket', Icons.badge_outlined),
          NavItem('Results', Icons.assessment_outlined),
          NavItem('Transcript', Icons.description_outlined),
          NavItem('Calendar', Icons.calendar_month_outlined),
          NavItem('Events', Icons.event_outlined),
          NavItem('Clubs', Icons.groups_outlined),
          NavItem('Library', Icons.local_library_outlined),
          NavItem('Hostel', Icons.hotel_outlined),
          NavItem('Transport', Icons.directions_bus_outlined),
          NavItem('Cafeteria', Icons.restaurant_outlined),
          NavItem('Fee Summary', Icons.account_balance_wallet_outlined),
          NavItem('Payment History', Icons.payments_outlined),
          NavItem('Receipts', Icons.receipt_long_outlined),
          NavItem('Documents', Icons.folder_outlined),
          NavItem('Career', Icons.work_outline),
          NavItem('Notifications', Icons.notifications_none_rounded),
          NavItem('Tasks', Icons.task_alt_outlined),
          NavItem('Messages', Icons.message_outlined),
          NavItem('Requests', Icons.support_agent_outlined),
          NavItem('Profile', Icons.person_outline),
          NavItem('Settings', Icons.settings_outlined),
          NavItem('Help & Support', Icons.help_outline_rounded),
        ];

      case UserRole.teacher:
        return const [
          NavItem('Dashboard', Icons.dashboard_outlined),
          NavItem('My Courses', Icons.menu_book_outlined),
          NavItem('Course Workspace', Icons.school_outlined),
          NavItem('Assignments', Icons.assignment_outlined),
          NavItem('Create Assignment', Icons.add_task_outlined),
          NavItem('Submissions', Icons.inbox_outlined),
          NavItem('Grading', Icons.grading_outlined),
          NavItem('Attendance', Icons.fact_check_outlined),
          NavItem('Students', Icons.people_outline),
          NavItem('Course Materials', Icons.folder_copy_outlined),
          NavItem('Calendar', Icons.calendar_month_outlined),
          NavItem('Analytics', Icons.analytics_outlined),
          NavItem('Notifications', Icons.notifications_none_rounded),
          NavItem('Messages', Icons.message_outlined),
          NavItem('Profile', Icons.person_outline),
          NavItem('Settings', Icons.settings_outlined),
          NavItem('Help & Support', Icons.help_outline),
        ];

      case UserRole.admin:
        return const [
          NavItem('Dashboard', Icons.dashboard_outlined),
          NavItem('Students', Icons.people_outline),
          NavItem('Teachers', Icons.co_present_outlined),
          NavItem('Staff', Icons.badge_outlined),
          NavItem('Courses', Icons.school_outlined),
          NavItem('Departments', Icons.account_tree_outlined),
          NavItem('Programmes', Icons.account_balance_outlined),
          NavItem('Subjects', Icons.menu_book_outlined),
          NavItem('Timetable', Icons.schedule_outlined),
          NavItem('Exams', Icons.event_note_outlined),
          NavItem('Academic Calendar', Icons.calendar_month_outlined),
          NavItem('Assignments', Icons.assignment_outlined),
          NavItem('Submissions', Icons.inbox_outlined),
          NavItem('Grades', Icons.grading_outlined),
          NavItem('Attendance', Icons.fact_check_outlined),
          NavItem('Announcements', Icons.campaign_outlined),
          NavItem('Events', Icons.event_outlined),
          NavItem('Facilities', Icons.business_outlined),
          NavItem('Finance', Icons.account_balance_wallet_outlined),
          NavItem('Requests', Icons.support_agent_outlined),
          NavItem('Reports', Icons.bar_chart_outlined),
          NavItem('Notifications', Icons.notifications_none_rounded),
          NavItem('Audit Logs', Icons.history_outlined),
          NavItem('Settings', Icons.settings_outlined),
          NavItem('Help & Support', Icons.help_outline),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool desktop = constraints.maxWidth >= 1000;

        return Scaffold(
          appBar: _topBar(desktop),

          // Mobile/tablet uses Drawer.
          // Desktop/web uses the custom sidebar below.
          drawer: desktop ? null : _drawer(),

          body: Row(
            children: [
              if (desktop && desktopSidebarVisible)
                SizedBox(
                  width: 250,
                  child: _sidebar(),
                ),

              Expanded(
                child: _page(),
              ),
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // APP BAR
  // ===========================================================================

  PreferredSizeWidget _topBar(bool desktop) {
    return AppBar(
      toolbarHeight: 70,

      // IMPORTANT:
      // The hamburger is now visible on BOTH desktop/web and mobile.
      leading: Builder(
        builder: (context) {
          return IconButton(
            tooltip: desktop
                ? (desktopSidebarVisible
                ? 'Hide navigation'
                : 'Show navigation')
                : 'Open navigation',
            icon: const Icon(Icons.menu),

            onPressed: () {
              if (desktop) {
                // Desktop/Web:
                // show/hide the left sidebar.
                setState(() {
                  desktopSidebarVisible = !desktopSidebarVisible;
                });
              } else {
                // Mobile:
                // open the Drawer.
                Scaffold.of(context).openDrawer();
              }
            },
          );
        },
      ),

      titleSpacing: desktop ? 22 : 4,

      title: Row(
        children: [
          Image.asset(
            'assets/images/sgu_logo.png',
            width: 34,
            height: 34,
          ),

          const SizedBox(width: 10),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SGU Student Campus',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'University ERP Portal',
                style: TextStyle(
                  fontSize: 10,
                  color: AppTheme.muted,
                ),
              ),
            ],
          ),
        ],
      ),

      actions: [
        // ---------------------------------------------------------------------
        // DESKTOP SEARCH
        // ---------------------------------------------------------------------
        if (desktop)
          SizedBox(
            width: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          )
        else
        // -------------------------------------------------------------------
        // MOBILE SEARCH
        // -------------------------------------------------------------------
          IconButton(
            tooltip: 'Search',
            onPressed: () {
              _snack(
                'Search is ready for API integration.',
              );
            },
            icon: const Icon(Icons.search),
          ),

        // ---------------------------------------------------------------------
        // NOTIFICATIONS
        // ---------------------------------------------------------------------
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {
            _snack('Notifications opened.');
          },
          icon: const Icon(
            Icons.notifications_none_rounded,
          ),
        ),

        // ---------------------------------------------------------------------
        // PROFILE / ROLE SWITCHER
        // ---------------------------------------------------------------------
        PopupMenuButton<UserRole>(
          tooltip: 'Switch demo portal',

          onSelected: (value) {
            setState(() {
              role = value;
              selected = 'Dashboard';
            });
          },

          itemBuilder: (context) => const [
            PopupMenuItem(
              value: UserRole.student,
              child: Text('Student Portal'),
            ),
            PopupMenuItem(
              value: UserRole.teacher,
              child: Text('Teacher Portal'),
            ),
            PopupMenuItem(
              value: UserRole.admin,
              child: Text('Admin Portal'),
            ),
          ],

          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Color(0xFFFFE1E1),
              child: Text(
                'SM',
                style: TextStyle(
                  color: AppTheme.darkRed,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // DESKTOP SIDEBAR
  // ===========================================================================

  Widget _sidebar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: AppTheme.border,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: _navList(),
      ),
    );
  }

  // ===========================================================================
  // MOBILE DRAWER
  // ===========================================================================

  Widget _drawer() {
    return Drawer(
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: _navList(),
        ),
      ),
    );
  }

  // ===========================================================================
  // NAVIGATION LIST
  // ===========================================================================

  Widget _navList() {
    final String portal = switch (role) {
      UserRole.student => 'STUDENT PORTAL',
      UserRole.teacher => 'TEACHER PORTAL',
      UserRole.admin => 'ADMIN PORTAL',
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        10,
        14,
        10,
        20,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            10,
            4,
            10,
            14,
          ),
          child: Text(
            portal,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.muted,
              fontWeight: FontWeight.w800,
              letterSpacing: .6,
            ),
          ),
        ),

        for (final item in navItems)
          _navTile(item),
      ],
    );
  }

  // ===========================================================================
  // NAVIGATION TILE
  // ===========================================================================

  Widget _navTile(NavItem item) {
    final bool active = selected == item.label;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 2,
      ),
      child: ListTile(
        dense: true,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),

        selected: active,

        selectedTileColor:
        AppTheme.red.withValues(alpha: .08),

        leading: Icon(
          item.icon,
          size: 20,
          color: active
              ? AppTheme.red
              : AppTheme.muted,
        ),

        title: Text(
          item.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: active
                ? FontWeight.w800
                : FontWeight.w500,
            color: active
                ? AppTheme.red
                : AppTheme.navy,
          ),
        ),

        onTap: () {
          setState(() {
            selected = item.label;
          });

          // Close mobile drawer after selection.
          if (
          Navigator.canPop(context) &&
              MediaQuery.sizeOf(context).width < 1000
          ) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // ===========================================================================
  // PAGE ROUTER
  // ===========================================================================

  Widget _page() {
    switch (role) {
      case UserRole.student:
        return _studentPage();

      case UserRole.teacher:
        return _teacherPage();

      case UserRole.admin:
        return _adminPage();
    }
  }

  // ===========================================================================
  // STUDENT PAGES
  // ===========================================================================

  Widget _studentPage() {
    switch (selected) {
      case 'Dashboard':
        return StudentDashboard(onNavigate: (page) => setState(() => selected = page));

      case 'My Courses':
        return const StudentCoursesPage();

      case 'Assignments':
        return const StudentAssignmentsPage();

      case 'Attendance':
        return const StudentAttendancePage();

      case 'Timetable':
        return const StudentTimetablePage();

      case 'Academic Progress':
        return const StudentProgressPage();

      case 'Course Registration':
        return const StudentRegistrationPage();

      case 'Exam Schedule':
        return const StudentExamsPage();

      case 'Hall Ticket':
        return const StudentHallTicketPage();

      case 'Results':
        return const StudentResultsPage();

      case 'Transcript':
        return const StudentTranscriptPage();

      case 'Calendar':
        return const StudentCalendarPage();

      case 'Events':
        return const StudentEventsPage();

      case 'Clubs':
        return const StudentClubsPage();

      case 'Library':
        return const StudentLibraryPage();

      case 'Hostel':
        return const StudentHostelPage();

      case 'Transport':
        return const StudentTransportPage();

      case 'Cafeteria':
        return const StudentCafeteriaPage();

      case 'Fee Summary':
        return const StudentFinancePage();

      case 'Payment History':
        return const StudentFinancePage();

      case 'Receipts':
        return const StudentFinancePage();

      case 'Documents':
        return const StudentDocumentsPage();

      case 'Career':
        return const StudentCareerPage();

      case 'Notifications':
        return const StudentNotificationsPage();

      case 'Tasks':
        return const StudentTasksPage();

      case 'Messages':
        return const StudentMessagesPage();

      case 'Requests':
        return const StudentRequestsPage();

      case 'Profile':
        return const StudentProfilePage();

      case 'Settings':
        return const StudentSettingsPage();

      case 'Help & Support':
        return const StudentHelpSupportPage();

      default:
        return GenericModulePage(
          title: selected,
          role: role,
        );
    }
  }

  // ===========================================================================
  // TEACHER PAGES
  // ===========================================================================

  Widget _teacherPage() {
    switch (selected) {
      case 'Dashboard':
        return TeacherDashboardPage(onNavigate: (page) => setState(() => selected = page));

      case 'My Courses':
        return const TeacherCoursesPage();

      case 'Course Workspace':
        return const CourseWorkspacePage(
          courseId: 'ml',
        );

      case 'Assignments':
        return const TeacherAssignmentsPage();

      case 'Create Assignment':
        return const TeacherAssignmentsPage();

      case 'Submissions':
        return const TeacherSubmissionsPage();

      case 'Grading':
        return const TeacherGradingPage();

      case 'Attendance':
        return const TeacherAttendancePage();

      case 'Students':
        return const TeacherStudentsPage();

      case 'Course Materials':
        return const TeacherMaterialsPage();

      case 'Calendar':
        return const TeacherCalendarPage();

      case 'Analytics':
        return const TeacherAnalyticsPage();

      case 'Notifications':
        return const NotificationsPage();

      case 'Messages':
        return const MessagesPage();

      case 'Profile':
        return const TeacherProfilePage();

      case 'Settings':
        return const TeacherSettingsPage();

      case 'Help & Support':
        return const TeacherHelpSupportPage();

      default:
        return GenericModulePage(
          title: selected,
          role: role,
        );
    }
  }

  // ===========================================================================
  // ADMIN PAGES
  // ===========================================================================

  Widget _adminPage() {
    switch (selected) {
      case 'Dashboard':
        return AdminDashboardPage(onNavigate: (page) => setState(() => selected = page));

      case 'Students':
        return const AdminStudentsPage();

      case 'Teachers':
        return const AdminTeachersPage();

      case 'Staff':
        return const AdminStaffPage();

      case 'Courses':
        return const AdminCoursesPage();

      case 'Departments':
        return const AdminDepartmentsPage();

      case 'Programmes':
        return const AdminProgrammesPage();

      case 'Subjects':
        return const AdminSubjectsPage();

      case 'Timetable':
        return const AdminTimetablePage();

      case 'Exams':
        return const AdminExamsPage();

      case 'Academic Calendar':
        return const AdminAcademicCalendarPage();

      case 'Assignments':
        return const AdminAssignmentsPage();

      case 'Submissions':
        return const AdminSubmissionsPage();

      case 'Grades':
        return const AdminGradesPage();

      case 'Attendance':
        return const AdminAttendancePage();

      case 'Announcements':
        return const AdminAnnouncementsPage();

      case 'Events':
        return const AdminEventsPage();

      case 'Facilities':
        return const AdminFacilitiesPage();

      case 'Finance':
        return const AdminFinancePage();

      case 'Requests':
        return const AdminRequestsPage();

      case 'Reports':
        return const AdminReportsPage();

      case 'Notifications':
        return const AdminNotificationsPage();

      case 'Audit Logs':
        return const AdminAuditLogsPage();

      case 'Settings':
        return const AdminSettingsPage();

      case 'Help & Support':
        return const AdminHelpSupportPage();

      default:
        return GenericModulePage(
          title: selected,
          role: role,
        );
    }
  }

  // ===========================================================================
  // SNACKBAR
  // ===========================================================================

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

// =============================================================================
// NAVIGATION MODEL
// =============================================================================

class NavItem {
  final String label;
  final IconData icon;

  const NavItem(
      this.label,
      this.icon,
      );
}