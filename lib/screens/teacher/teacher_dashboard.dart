import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

class TeacherDashboardPage extends StatelessWidget {
  final Function(String)? onNavigate;
  const TeacherDashboardPage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) => PageContainer(
        title: 'Good Evening, Professor 👋',
        subtitle: 'Manage teaching, student attendance, and grading seamlessly.',
        child: Column(
          children: [
            LayoutBuilder(
              builder: (_, c) => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: c.maxWidth > 800 ? 4 : 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 2.3,
                children: [
                  _TeacherStat('Classes Today', '3', Icons.school_rounded, AppTheme.red, onTap: () => onNavigate?.call('Attendance')),
                  _TeacherStat('To Grade', '18', Icons.grading_rounded, AppTheme.warning, onTap: () => onNavigate?.call('Grading')),
                  _TeacherStat('Attendance', '2', Icons.fact_check_rounded, AppTheme.success, onTap: () => onNavigate?.call('Attendance')),
                  _TeacherStat('Deadlines', '4', Icons.assignment_rounded, AppTheme.info, onTap: () => onNavigate?.call('Assignments')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (_, c) => c.maxWidth > 850
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _TeachingToday(onNavigate: onNavigate)),
                        const SizedBox(width: 16),
                        Expanded(child: _TeacherActions(onNavigate: onNavigate)),
                      ],
                    )
                  : Column(
                      children: [
                        _TeachingToday(onNavigate: onNavigate),
                        const SizedBox(height: 24),
                        _TeacherActions(onNavigate: onNavigate),
                      ],
                    ),
            ),
          ],
        ),
      );
}

class _TeacherStat extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _TeacherStat(this.title, this.value, this.icon, this.color, {this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
          boxShadow: AppTheme.softShadow,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 11, color: AppTheme.muted, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.navy)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _TeachingToday extends StatelessWidget {
  final Function(String)? onNavigate;
  const _TeachingToday({this.onNavigate});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader("Today's Teaching", action: 'View All', onAction: () => onNavigate?.call('Attendance')),
          const SizedBox(height: 12),
          for (final x in const [
            ('09:00 AM', 'Deep Learning', 'Lab 204'),
            ('11:30 AM', 'Machine Learning', 'Room 305'),
            ('02:00 PM', 'Computer Vision', 'Lab 101'),
          ])
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
                  onTap: () => onNavigate?.call('Attendance'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.info.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.schedule_rounded, color: AppTheme.info, size: 20),
                  ),
                  title: Text(x.$2, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppTheme.navy)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('${x.$1} • ${x.$3}', style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded, color: AppTheme.muted, size: 20),
                ),
              ),
            ),
        ],
      );
}

class _TeacherActions extends StatelessWidget {
  final Function(String)? onNavigate;
  const _TeacherActions({this.onNavigate});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader('Action Required'),
          const SizedBox(height: 12),
          EmptyActionCard(
            icon: Icons.grading_rounded,
            title: 'Grade submissions',
            subtitle: '18 student submissions need review and grading.',
            onTap: () => onNavigate?.call('Grading'),
          ),
          const SizedBox(height: 12),
          EmptyActionCard(
            icon: Icons.fact_check_rounded,
            title: 'Mark attendance',
            subtitle: 'Two scheduled classes need attendance recorded today.',
            onTap: () => onNavigate?.call('Attendance'),
          ),
          const SizedBox(height: 12),
          EmptyActionCard(
            icon: Icons.campaign_rounded,
            title: 'Course announcement',
            subtitle: 'Publish an important update or notice to your students.',
            onTap: () => onNavigate?.call('Notifications'),
          ),
        ],
      );
}
