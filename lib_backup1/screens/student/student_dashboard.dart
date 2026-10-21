import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/calendar_widget.dart';
import '../../widgets/campus_visual_carousel.dart';
import '../../widgets/common.dart';
import '../../widgets/course_card.dart';
import '../../widgets/stat_card.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MockData.i;

    return PageContainer(
      title: 'Good Evening, Suzain 👋',
      subtitle: 'Stay on track with your academic journey.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth >= 1000;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (desktop) _desktopTop() else _mobileTop(),
              const SizedBox(height: 14),
              if (desktop)
                _desktopBody(context, data)
              else
                _mobileBody(context, data),
            ],
          );
        },
      ),
    );
  }

  Widget _desktopTop() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: _DashboardStats(),
        ),
        SizedBox(width: 14),
        Expanded(
          flex: 5,
          child: CampusVisualCarousel(compact: true),
        ),
      ],
    );
  }

  Widget _mobileTop() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CampusVisualCarousel(),
        SizedBox(height: 12),
        _DashboardStats(),
      ],
    );
  }

  Widget _desktopBody(BuildContext context, MockData data) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  _priorityRow(),
                  const SizedBox(height: 18),
                  const SectionHeader('My Courses', action: 'View All'),
                  const SizedBox(height: 8),
                  _courses(data),
                  const SizedBox(height: 16),
                  _quickAccess(),
                ],
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              flex: 4,
              child: Column(
                children: [
                  MiniCalendar(compact: true),
                  SizedBox(height: 12),
                  UpcomingEvents(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _schedule()),
            const SizedBox(width: 14),
            Expanded(child: _announcements()),
          ],
        ),
      ],
    );
  }

  Widget _mobileBody(BuildContext context, MockData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _mobilePriorityRow(),
        const SizedBox(height: 18),
        const SectionHeader('My Courses', action: 'View All'),
        const SizedBox(height: 8),
        _courses(data),
        const SizedBox(height: 16),
        _quickAccess(),
        const SizedBox(height: 18),
        _schedule(),
        const SizedBox(height: 18),
        const MiniCalendar(),
        const SizedBox(height: 12),
        const UpcomingEvents(),
        const SizedBox(height: 18),
        _announcements(),
      ],
    );
  }

  Widget _priorityRow() {
    return const Row(
      children: [
        Expanded(
          child: EmptyActionCard(
            icon: Icons.menu_book_outlined,
            title: 'Next Class',
            subtitle: 'Deep Learning • 09:00 AM – 10:00 AM • Lab 204',
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: EmptyActionCard(
            icon: Icons.assignment_outlined,
            title: 'Action Required',
            subtitle: 'Submit Deep Learning Assignment • Due 25 Sep',
          ),
        ),
      ],
    );
  }

  Widget _mobilePriorityRow() {
    return const Column(
      children: [
        EmptyActionCard(
          icon: Icons.menu_book_outlined,
          title: 'Next Class',
          subtitle: 'Deep Learning • 09:00 AM – 10:00 AM • Lab 204',
        ),
        SizedBox(height: 10),
        EmptyActionCard(
          icon: Icons.assignment_outlined,
          title: 'Action Required',
          subtitle: 'Submit Deep Learning Assignment • Due 25 Sep',
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
            maxCrossAxisExtent: 220,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: mobile ? 192 : 176,
          ),
          itemBuilder: (context, index) => CourseCard(
            course: data.courses[index],
          ),
        );
      },
    );
  }

  Widget _quickAccess() {
    const services = [
      (
        'Library',
        Icons.local_library_outlined,
        AppTheme.info,
      ),
      (
        'Career Services',
        Icons.work_outline,
        AppTheme.success,
      ),
      (
        'Clubs & Societies',
        Icons.groups_outlined,
        AppTheme.warning,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader('Quick Access'),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 560) {
              return Column(
                children: [
                  for (final service in services) ...[
                    _serviceCard(context, service),
                    const SizedBox(height: 8),
                  ],
                ],
              );
            }

            return Row(
              children: [
                for (var i = 0; i < services.length; i++) ...[
                  Expanded(
                    child: _serviceCard(context, services[i]),
                  ),
                  if (i < services.length - 1)
                    const SizedBox(width: 10),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _serviceCard(
    BuildContext context,
    (String, IconData, Color) service,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${service.$1} opened.'),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: service.$3.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  service.$2,
                  color: service.$3,
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  service.$1,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 18,
                color: AppTheme.muted,
              ),
            ],
          ),
        ),
      ),
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
        const SectionHeader("Today's Schedule", action: 'View All'),
        const SizedBox(height: 8),
        for (final item in schedule)
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.menu_book_outlined,
                color: AppTheme.info,
              ),
              title: Text(
                item.$1,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('${item.$2} • ${item.$3}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
      ],
    );
  }

  Widget _announcements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          'Recent Announcements',
          action: 'View All',
        ),
        const SizedBox(height: 8),
        for (final item in MockData.i.announcements)
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.campaign_outlined,
                color: AppTheme.red,
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text('${item.message} • ${item.age}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
      ],
    );
  }
}

class _DashboardStats extends StatelessWidget {
  const _DashboardStats();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 650 ? 2 : 1;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: columns == 1 ? 3.35 : 3.25,
          children: [
            StatCard(
              label: 'CGPA',
              value: '8.35',
              action: 'View Progress',
              icon: Icons.school_outlined,
              color: AppTheme.red,
            ),
            StatCard(
              label: 'Attendance',
              value: '82%',
              action: 'View Details',
              icon: Icons.bar_chart_outlined,
              color: AppTheme.success,
            ),
            StatCard(
              label: 'Credits',
              value: '96',
              action: 'View Transcript',
              icon: Icons.layers_outlined,
              color: AppTheme.info,
            ),
            StatCard(
              label: 'Semester',
              value: '6',
              action: 'View Details',
              icon: Icons.calendar_month_outlined,
              color: AppTheme.warning,
            ),
          ],
        );
      },
    );
  }
}
