import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import '../../models/models.dart';

class StudentRequestsPage extends StatefulWidget {
  const StudentRequestsPage({super.key});

  @override
  State<StudentRequestsPage> createState() => _StudentRequestsPageState();
}

class _StudentRequestsPageState extends State<StudentRequestsPage> {
  @override
  Widget build(BuildContext context) {
    final requests = MockData.i.requests;

    return PageContainer(
      title: 'Service Requests',
      subtitle: 'Submit and track academic or administrative service requests.',
      actions: [
        FilledButton.icon(
          onPressed: () => _showNewRequestDialog(context),
          style: FilledButton.styleFrom(backgroundColor: AppTheme.red),
          icon: const Icon(Icons.add, size: 16),
          label: const Text('New Request'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader('Active Requests'),
          const SizedBox(height: 12),
          if (requests.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(40), child: Text('No requests submitted yet.', style: TextStyle(color: AppTheme.muted))))
          else
            for (final req in requests)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.border),
                    boxShadow: AppTheme.softShadow,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.info.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.support_agent_rounded, color: AppTheme.info),
                    ),
                    title: Text(req.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppTheme.navy)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('Category: ${req.category} • Submitted on ${req.date}', style: const TextStyle(fontSize: 12, color: AppTheme.muted)),
                    ),
                    trailing: StatusChip(
                      req.status,
                      color: req.status == 'Approved' ? AppTheme.success : AppTheme.warning,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  void _showNewRequestDialog(BuildContext context) {
    final titleController = TextEditingController();
    String category = 'Academic';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('New Service Request', style: TextStyle(fontWeight: FontWeight.w800)),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Request Title / Purpose (e.g., Bonafide Certificate)'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: const [
                    DropdownMenuItem(value: 'Academic', child: Text('Academic')),
                    DropdownMenuItem(value: 'Facilities', child: Text('Facilities')),
                    DropdownMenuItem(value: 'Finance', child: Text('Finance')),
                    DropdownMenuItem(value: 'Hostel', child: Text('Hostel')),
                  ],
                  onChanged: (val) => setDialogState(() => category = val ?? 'Academic'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) return;
                setState(() {
                  MockData.i.requests.insert(
                    0,
                    ServiceRequest(
                      id: 'r_${DateTime.now().millisecondsSinceEpoch}',
                      title: titleController.text.trim(),
                      category: category,
                      status: 'Pending',
                      date: '25 Sep 2026',
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Service request submitted successfully!'), behavior: SnackBarBehavior.floating),
                );
              },
              child: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
