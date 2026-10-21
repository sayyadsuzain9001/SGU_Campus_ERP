import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'module_pages.dart';

class CourseWorkspacePage extends StatefulWidget {
  final String courseId;

  const CourseWorkspacePage({
    super.key,
    required this.courseId,
  });

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
    'Calendar',
  ];

  @override
  Widget build(BuildContext context) {
    final course = MockData.i.course(widget.courseId);

    return PageContainer(
      title: course.name,
      subtitle:
      '${course.code} • ${course.instructor} • ${course.room}',
      actions: [
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Course discussion tools are ready.'),
              ),
            );
          },
          icon: const Icon(Icons.forum_outlined, size: 17),
          label: const Text('Discussion'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  for (final item in tabs)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(item),
                        selected: tab == item,
                        onSelected: (_) {
                          setState(() {
                            tab = item;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _body(course),
        ],
      ),
    );
  }

  Widget _body(Course course) {
    switch (tab) {
      case 'Overview':
        return Column(
          children: [
            const EmptyActionCard(
              icon: Icons.school_outlined,
              title: 'Course Overview',
              subtitle:
              'Learning outcomes, instructor details and current progress.',
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Expanded(
                  child: EmptyActionCard(
                    icon: Icons.assignment_outlined,
                    title: 'Assignments',
                    subtitle: '3 active items',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: EmptyActionCard(
                    icon: Icons.fact_check_outlined,
                    title: 'Attendance',
                    subtitle: '82% overall',
                  ),
                ),
              ],
            ),
          ],
        );

      case 'Discussions':
        return const _DiscussionsContent();

      case 'Attendance':
        return const GenericModulePage(
          title: 'Course Attendance',
          role: UserRole.student,
        );

      case 'Grades':
        return const GenericModulePage(
          title: 'Course Grades',
          role: UserRole.student,
        );

      default:
        return GenericModulePage(
          title: tab,
          role: UserRole.student,
        );
    }
  }
}

class _DiscussionsContent extends StatefulWidget {
  const _DiscussionsContent();

  @override
  State<_DiscussionsContent> createState() => _DiscussionsContentState();
}

class _DiscussionsContentState extends State<_DiscussionsContent> {
  bool expanded = true;

  final List<_DiscussionItem> discussions = const [
    _DiscussionItem(
      title: 'Route and navigator widget',
      lastPost: 'Last post at Oct 7, 11:30 AM',
      description:
      'Discussion about route navigation, named routes and moving between course pages.',
    ),
    _DiscussionItem(
      title: 'form widget customization',
      lastPost: 'Last post at Oct 7, 7:25 AM',
      description:
      'Share ideas about customizing Flutter form widgets, validation and input styling.',
    ),
  ];

  void _openDiscussion(_DiscussionItem item) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item.title),
          content: Text(item.description),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                    content: Text('Opened discussion: ${item.title}'),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
  }

  void _createDiscussion() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New discussion form opened.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      AnimatedRotation(
                        turns: expanded ? 0.0 : -0.25,
                        duration: const Duration(milliseconds: 180),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppTheme.navy,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Discussions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy,
                        ),
                      ),
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: _createDiscussion,
                        icon: const Icon(Icons.add, size: 17),
                        label: const Text('New Discussion'),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              if (expanded)
                for (final item in discussions)
                  _DiscussionTile(
                    item: item,
                    onTap: () => _openDiscussion(item),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Use discussions to ask questions, share solutions and communicate with classmates.',
          style: TextStyle(
            color: AppTheme.muted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _DiscussionTile extends StatelessWidget {
  final _DiscussionItem item;
  final VoidCallback onTap;

  const _DiscussionTile({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 92,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppTheme.border,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              child: const Icon(
                Icons.circle,
                size: 16,
                color: AppTheme.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.info,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.lastPost,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.navy,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppTheme.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _DiscussionItem {
  final String title;
  final String lastPost;
  final String description;

  const _DiscussionItem({
    required this.title,
    required this.lastPost,
    required this.description,
  });
}
