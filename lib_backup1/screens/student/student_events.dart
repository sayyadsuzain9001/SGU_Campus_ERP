import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

class StudentEventsPage extends StatelessWidget {
  const StudentEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const events = [
      (
        'AI & Robotics Workshop',
        '30 Sep • 10:00 AM',
        'Innovation Lab',
        Icons.smart_toy_outlined,
        AppTheme.info,
      ),
      (
        'Campus Sports Meet',
        '03 Oct • 04:00 PM',
        'University Sports Ground',
        Icons.sports_basketball_outlined,
        AppTheme.success,
      ),
      (
        'Career & Internship Fair',
        '08 Oct • 11:00 AM',
        'Convention Centre',
        Icons.work_outline,
        AppTheme.warning,
      ),
    ];

    return PageContainer(
      title: 'Campus Activities',
      subtitle: 'Discover workshops, events and student opportunities.',
      actions: [
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Activity filters opened.'),
              ),
            );
          },
          icon: const Icon(Icons.tune_outlined, size: 18),
          label: const Text('Filter'),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900 ? 3 : 1;

          if (columns == 1) {
            return Column(
              children: [
                for (final event in events) ...[
                  _eventCard(context, event),
                  const SizedBox(height: 10),
                ],
              ],
            );
          }

          return GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              for (final event in events) _eventCard(context, event),
            ],
          );
        },
      ),
    );
  }

  Widget _eventCard(
    BuildContext context,
    (
      String,
      String,
      String,
      IconData,
      Color,
    ) event,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${event.$1} selected.'),
              action: SnackBarAction(
                label: 'Register',
                onPressed: () {},
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: event.$5.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  event.$4,
                  color: event.$5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                event.$1,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                event.$2,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.muted,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                event.$3,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.muted,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration started for ${event.$1}.'),
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
