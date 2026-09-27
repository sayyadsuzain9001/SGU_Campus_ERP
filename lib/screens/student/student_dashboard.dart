import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/course_card.dart';
import '../../widgets/calendar_widget.dart';

class StudentDashboard extends StatelessWidget {
  final Function(String)? onNavigate;
  const StudentDashboard({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final data = MockData.i;
    return PageContainer(
      title: 'Good Evening, Suzain 👋',
      subtitle: 'Stay on track with your academic journey and campus updates.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth >= 1000;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (desktop) _desktopTop(context, data) else _mobileTop(context, data),
              const SizedBox(height: 24),
              if (desktop) _desktopBody(context, data) else _mobileBody(context, data),
            ],
          );
        },
      ),
    );
  }

  Widget _desktopTop(BuildContext context, MockData data) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: _stats()),
          const SizedBox(width: 16),
          Expanded(flex: 5, child: _campusBanner(context)),
        ],
      );

  Widget _mobileTop(BuildContext context, MockData data) => Column(
        children: [
          _stats(),
          const SizedBox(height: 16),
          _campusBanner(context),
        ],
      );

  Widget _stats() => LayoutBuilder(
        builder: (_, constraints) {
          final cols = constraints.maxWidth > 650 ? 2 : 1;
          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: cols,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 2.8,
            children: [
              StatCard(
                label: 'CGPA',
                value: '8.35',
                action: 'View Progress',
                icon: Icons.school_rounded,
                color: AppTheme.red,
                onTap: () => onNavigate?.call('Academic Progress'),
              ),
              StatCard(
                label: 'Attendance',
                value: '82%',
                action: 'View Details',
                icon: Icons.bar_chart_rounded,
                color: AppTheme.success,
                onTap: () => onNavigate?.call('Attendance'),
              ),
              StatCard(
                label: 'Credits',
                value: '96',
                action: 'View Transcript',
                icon: Icons.layers_rounded,
                color: AppTheme.info,
                onTap: () => onNavigate?.call('Transcript'),
              ),
              StatCard(
                label: 'Semester',
                value: '6',
                action: 'View Details',
                icon: Icons.calendar_month_rounded,
                color: AppTheme.warning,
                onTap: () => onNavigate?.call('Exam Schedule'),
              ),
            ],
          );
        },
      );

  Widget _campusBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.softShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 196,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/sgu_campus.png', fit: BoxFit.cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.navy.withValues(alpha: 0.92), AppTheme.navy.withValues(alpha: 0.3)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'FEATURED CAMPUS',
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'SANJAY GHODAWAT\nUNIVERSITY',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, height: 1.1),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: () => onNavigate?.call('Events'),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.navy,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.red),
                      label: const Text('Explore Campus', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopBody(BuildContext context, MockData data) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _priorityRow(),
                const SizedBox(height: 24),
                SectionHeader('My Courses', action: 'View All', onAction: () => onNavigate?.call('My Courses')),
                const SizedBox(height: 12),
                _courses(data),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _schedule()),
                    const SizedBox(width: 16),
                    Expanded(child: _announcements()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                GestureDetector(onTap: () => onNavigate?.call('Calendar'), child: const MiniCalendar(compact: true)),
                const SizedBox(height: 16),
                GestureDetector(onTap: () => onNavigate?.call('Events'), child: const UpcomingEvents()),
              ],
            ),
          ),
        ],
      );

  Widget _mobileBody(BuildContext context, MockData data) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _mobilePriorityRow(),
          const SizedBox(height: 24),
          SectionHeader('My Courses', action: 'View All', onAction: () => onNavigate?.call('My Courses')),
          const SizedBox(height: 12),
          _courses(data),
          const SizedBox(height: 24),
          _schedule(),
          const SizedBox(height: 24),
          GestureDetector(onTap: () => onNavigate?.call('Calendar'), child: const MiniCalendar()),
          const SizedBox(height: 16),
          GestureDetector(onTap: () => onNavigate?.call('Events'), child: const UpcomingEvents()),
          const SizedBox(height: 24),
          _announcements(),
        ],
      );

  Widget _priorityRow() {
    return Row(
      children: [
        Expanded(
          child: EmptyActionCard(
            icon: Icons.menu_book_rounded,
            title: 'Next Class',
            subtitle: 'Deep Learning • 09:00 AM – 10:00 AM • Lab 204',
            onTap: () => onNavigate?.call('Timetable'),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: EmptyActionCard(
            icon: Icons.assignment_rounded,
            title: 'Action Required',
            subtitle: 'Submit Deep Learning Assignment • Due 25 Sep',
            onTap: () => onNavigate?.call('Assignments'),
          ),
        ),
      ],
    );
  }

  Widget _mobilePriorityRow() {
    return Column(
      children: [
        EmptyActionCard(
          icon: Icons.menu_book_rounded,
          title: 'Next Class',
          subtitle: 'Deep Learning • 09:00 AM – 10:00 AM • Lab 204',
          onTap: () => onNavigate?.call('Timetable'),
        ),
        const SizedBox(height: 12),
        EmptyActionCard(
          icon: Icons.assignment_rounded,
          title: 'Action Required',
          subtitle: 'Submit Deep Learning Assignment • Due 25 Sep',
          onTap: () => onNavigate?.call('Assignments'),
        ),
      ],
    );
  }

  Widget _courses(MockData data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mobile = constraints.maxWidth < 600;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.courses.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 240,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            mainAxisExtent: mobile ? 200 : 188,
          ),
          itemBuilder: (context, index) => CourseCard(
            course: data.courses[index],
            onTap: () => onNavigate?.call('My Courses'),
          ),
        );
      },
    );
  }

  Widget _schedule() {
    const schedule = [
      ('Deep Learning', '09:00 AM – 10:00 AM', 'Lab 204'),
      ('Machine Learning', '11:30 AM – 01:00 PM', 'Room 305'),
      ('Computer Vision', '02:00 PM – 04:00 PM', 'Lab 101'),
      ('Project Discussion', '04:30 PM – 05:30 PM', 'Online'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader("Today's Schedule", action: 'View All', onAction: () => onNavigate?.call('Timetable')),
        const SizedBox(height: 12),
        for (final item in schedule)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
                boxShadow: AppTheme.softShadow,
              ),
              child: ListTile(
                onTap: () => onNavigate?.call('Timetable'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.info.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.menu_book_rounded, color: AppTheme.info, size: 20),
                ),
                title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppTheme.navy)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('${item.$2} • ${item.$3}', style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.muted, size: 20),
              ),
            ),
          ),
      ],
    );
  }

  Widget _announcements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader('Recent Announcements', action: 'View All', onAction: () => onNavigate?.call('Notifications')),
        const SizedBox(height: 12),
        for (final item in MockData.i.announcements)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
                boxShadow: AppTheme.softShadow,
              ),
              child: ListTile(
                onTap: () => onNavigate?.call('Notifications'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.campaign_rounded, color: AppTheme.red, size: 20),
                ),
                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppTheme.navy)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('${item.message} • ${item.age}', style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.muted, size: 20),
              ),
            ),
          ),
      ],
    );
  }
}
