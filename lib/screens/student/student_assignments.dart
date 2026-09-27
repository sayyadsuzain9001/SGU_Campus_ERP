import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../widgets/assignment_card.dart';
import '../shared/assignment_details.dart';

class StudentAssignmentsPage extends StatelessWidget {
  const StudentAssignmentsPage({super.key});
  @override
  Widget build(BuildContext context) => PageContainer(title: 'Assignments', subtitle: 'Track upcoming, submitted and graded work.', child: Column(children: [
        Wrap(spacing: 8, runSpacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [StatusChip('All', color: AppTheme.red), const StatusChip('Pending'), const StatusChip('Submitted', color: AppTheme.info), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.filter_list), label: const Text('Filter'))]),
        const SizedBox(height: 14),
        for (final assignment in MockData.i.assignments) Padding(padding: const EdgeInsets.only(bottom: 10), child: AssignmentCard(assignment: assignment, courseName: MockData.i.course(assignment.courseId).name, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AssignmentDetailsPage(assignmentId: assignment.id))))),
      ]));
}
