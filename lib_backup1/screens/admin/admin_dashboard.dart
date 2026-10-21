import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

class AdminDashboardPage extends StatelessWidget {
  final Function(String)? onNavigate;
  const AdminDashboardPage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) => PageContainer(
        title: 'University Administration 🏛️',
        subtitle: 'Monitor university-wide academic metrics, requests, and operational activity.',
        child: Column(
          children: [
            LayoutBuilder(
              builder: (_, c) => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: c.maxWidth > 850 ? 4 : 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 2.3,
                children: [
                  _AdminStat('Students', '4,820', Icons.people_outline_rounded, AppTheme.info, onTap: () => onNavigate?.call('Students')),
                  _AdminStat('Teachers', '286', Icons.co_present_rounded, AppTheme.purple, onTap: () => onNavigate?.call('Teachers')),
                  _AdminStat('Courses', '412', Icons.school_rounded, AppTheme.success, onTap: () => onNavigate?.call('Courses')),
                  _AdminStat('Requests', '38', Icons.support_agent_rounded, AppTheme.warning, onTap: () => onNavigate?.call('Requests')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (_, c) => c.maxWidth > 850
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _AdminActivity(onNavigate: onNavigate)),
                        const SizedBox(width: 16),
                        Expanded(child: _AdminActions(onNavigate: onNavigate)),
                      ],
                    )
                  : Column(
                      children: [
                        _AdminActivity(onNavigate: onNavigate),
                        const SizedBox(height: 24),
                        _AdminActions(onNavigate: onNavigate),
                      ],
                    ),
            ),
          ],
        ),
      );
}

class _AdminStat extends StatelessWidget {
  final String title, value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  const _AdminStat(this.title, this.value, this.icon, this.color, {this.onTap});

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

class _AdminActivity extends StatelessWidget {
  final Function(String)? onNavigate;
  const _AdminActivity({this.onNavigate});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader('University Activity', action: 'View All', onAction: () => onNavigate?.call('Audit Logs')),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () => onNavigate?.call('Students'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFEFF6FF),
                    child: Icon(Icons.person_add_outlined, color: AppTheme.info, size: 20),
                  ),
                  title: const Text('126 new student records', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppTheme.navy)),
                  subtitle: const Text('Admissions department • Today', style: TextStyle(fontSize: 11, color: AppTheme.muted)),
                  trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: AppTheme.muted),
                ),
                const Divider(height: 1, color: AppTheme.border),
                ListTile(
                  onTap: () => onNavigate?.call('Assignments'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFFEF3C7),
                    child: Icon(Icons.assignment_outlined, color: AppTheme.warning, size: 20),
                  ),
                  title: const Text('84 assignments published', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppTheme.navy)),
                  subtitle: const Text('Academic system • Today', style: TextStyle(fontSize: 11, color: AppTheme.muted)),
                  trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: AppTheme.muted),
                ),
                const Divider(height: 1, color: AppTheme.border),
                ListTile(
                  onTap: () => onNavigate?.call('Finance'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFECFDF5),
                    child: Icon(Icons.payments_outlined, color: AppTheme.success, size: 20),
                  ),
                  title: const Text('RM 48,500 payments received', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: AppTheme.navy)),
                  subtitle: const Text('Finance department • Today', style: TextStyle(fontSize: 11, color: AppTheme.muted)),
                  trailing: const Icon(Icons.chevron_right_rounded, size: 18, color: AppTheme.muted),
                ),
              ],
            ),
          ),
        ],
      );
}

class _AdminActions extends StatelessWidget {
  final Function(String)? onNavigate;
  const _AdminActions({this.onNavigate});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader('Action Required'),
          const SizedBox(height: 12),
          EmptyActionCard(
            icon: Icons.approval_rounded,
            title: 'Pending requests',
            subtitle: '38 service and administrative requests require processing.',
            onTap: () => onNavigate?.call('Requests'),
          ),
          const SizedBox(height: 12),
          EmptyActionCard(
            icon: Icons.history_rounded,
            title: 'Audit review',
            subtitle: '12 recent system and administrative changes need review.',
            onTap: () => onNavigate?.call('Audit Logs'),
          ),
        ],
      );
}
