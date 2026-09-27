import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'module_pages.dart';

class CourseWorkspacePage extends StatefulWidget {
  final String courseId;
  const CourseWorkspacePage({super.key, required this.courseId});
  @override
  State<CourseWorkspacePage> createState() => _CourseWorkspacePageState();
}

class _CourseWorkspacePageState extends State<CourseWorkspacePage> {
  String tab = 'Overview';
  final List<String> tabs = const [
    'Overview',
    'Syllabus',
    'Announcements',
    'Modules',
    'Assignments',
    'Quizzes & Exams',
    'Discussions',
    'Grades',
    'Attendance',
    'People',
    'Files',
    'Calendar'
  ];

  @override
  Widget build(BuildContext context) {
    final course = MockData.i.course(widget.courseId);
    return PageContainer(
      title: course.name,
      subtitle: '${course.code} • ${course.instructor} • ${course.room}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gorgeous Course Header Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.navy, AppTheme.navy.withValues(alpha: 0.85)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.softShadow,
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.auto_stories_rounded, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(course.code, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(course.room, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Instructor: ${course.instructor}',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // Sleek Tab Bar
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
              boxShadow: AppTheme.softShadow,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final item in tabs)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(item),
                        selected: tab == item,
                        selectedColor: AppTheme.red,
                        labelStyle: TextStyle(
                          color: tab == item ? Colors.white : AppTheme.navy,
                          fontWeight: tab == item ? FontWeight.w800 : FontWeight.w600,
                          fontSize: 12,
                        ),
                        backgroundColor: AppTheme.bg,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onSelected: (_) => setState(() => tab = item),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          _body(course),
        ],
      ),
    );
  }

  Widget _body(Course course) => switch (tab) {
        'Overview' => Column(
            children: [
              EmptyActionCard(
                icon: Icons.school_rounded,
                title: 'Course Overview & Syllabus',
                subtitle: 'Learning outcomes, course materials, grading policy and progress.',
                onTap: () => setState(() => tab = 'Syllabus'),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: EmptyActionCard(
                      icon: Icons.assignment_rounded,
                      title: 'Assignments',
                      subtitle: '3 active pending submissions',
                      onTap: () => setState(() => tab = 'Assignments'),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: EmptyActionCard(
                      icon: Icons.fact_check_rounded,
                      title: 'Attendance',
                      subtitle: '${course.attendance}% overall attendance rate',
                      onTap: () => setState(() => tab = 'Attendance'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        'Attendance' => const GenericModulePage(title: 'Course Attendance', role: UserRole.student),
        'Grades' => const GenericModulePage(title: 'Course Grades', role: UserRole.student),
        _ => GenericModulePage(title: tab, role: UserRole.student),
      };
}
