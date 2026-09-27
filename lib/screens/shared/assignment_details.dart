import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../models/models.dart';

class AssignmentDetailsPage extends StatefulWidget {
  final String assignmentId;
  const AssignmentDetailsPage({super.key, required this.assignmentId});

  @override
  State<AssignmentDetailsPage> createState() => _AssignmentDetailsPageState();
}

class _AssignmentDetailsPageState extends State<AssignmentDetailsPage> {
  bool uploaded = false;
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    final assignment = MockData.i.assignments.firstWhere(
      (item) => item.id == widget.assignmentId,
      orElse: () => MockData.i.assignments.first,
    );
    final course = MockData.i.course(assignment.courseId);
    final isSubmitted = submitted || assignment.status == RecordStatus.submitted;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
          tooltip: 'Back',
        ),
        title: const Text('Assignment Details', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
      ),
      body: PageContainer(
        title: assignment.title,
        subtitle: '${course.name} • ${assignment.marks} marks',
        actions: [
          StatusChip(
            isSubmitted ? 'Submitted' : 'Pending',
            color: isSubmitted ? AppTheme.success : AppTheme.warning,
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
                boxShadow: AppTheme.softShadow,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.navy)),
                    const SizedBox(height: 10),
                    const Text('Complete the assigned work and upload your final submission before the deadline. Include all required files and references.'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: AppTheme.red),
                        const SizedBox(width: 6),
                        Text('Due: ${assignment.due.day} Sep • 11:59 PM', style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.red)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
                boxShadow: AppTheme.softShadow,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Submission Portal', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.navy)),
                    const SizedBox(height: 14),
                    if (isSubmitted) ...[
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.success.withValues(alpha: 0.3)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_circle_rounded, color: AppTheme.success),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Assignment successfully submitted! Waiting for instructor grading.',
                                style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.success),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() => uploaded = true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('File "assignment_solution.pdf" attached successfully!'), behavior: SnackBarBehavior.floating),
                          );
                        },
                        icon: Icon(uploaded ? Icons.check_circle_outline : Icons.upload_file_outlined, color: uploaded ? AppTheme.success : AppTheme.info),
                        label: Text(uploaded ? 'File Attached: assignment_solution.pdf' : 'Upload File (.pdf, .zip, .docx)'),
                      ),
                      const SizedBox(height: 14),
                      FilledButton.icon(
                        onPressed: () {
                          setState(() => submitted = true);
                          final index = MockData.i.assignments.indexWhere((a) => a.id == widget.assignmentId);
                          if (index != -1) {
                            MockData.i.assignments[index] = MockData.i.assignments[index].copyWith(status: RecordStatus.submitted);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Assignment submitted successfully! 🎉'), behavior: SnackBarBehavior.floating),
                          );
                        },
                        style: FilledButton.styleFrom(backgroundColor: AppTheme.red),
                        icon: const Icon(Icons.send_rounded),
                        label: const Text('Submit Assignment'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
