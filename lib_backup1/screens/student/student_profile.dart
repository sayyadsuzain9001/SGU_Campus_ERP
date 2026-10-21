import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    final data = MockData.i;
    return PageContainer(
      title: 'My Profile',
      subtitle: 'Personal and academic information.',
      actions: [
        OutlinedButton.icon(
          onPressed: () => _showEditDialog(context),
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Edit Profile'),
        ),
      ],
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
              boxShadow: AppTheme.softShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Color(0xFFFFD9D5),
                    child: Text('SM', style: TextStyle(color: AppTheme.darkRed, fontSize: 20, fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.studentName, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppTheme.navy)),
                        const SizedBox(height: 5),
                        Text('${data.studentId} • ${data.programme}', style: const TextStyle(color: AppTheme.muted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              children: [
                _row(Icons.badge_outlined, 'Student ID', data.studentId),
                const Divider(height: 1, color: AppTheme.border),
                _row(Icons.school_outlined, 'Programme', data.programme),
                const Divider(height: 1, color: AppTheme.border),
                _row(Icons.email_outlined, 'Email', data.email),
                const Divider(height: 1, color: AppTheme.border),
                _row(Icons.calendar_month_outlined, 'Semester', data.semester),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.muted),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value, style: const TextStyle(color: AppTheme.navy, fontWeight: FontWeight.w700)),
    );
  }

  void _showEditDialog(BuildContext context) {
    final data = MockData.i;
    final nameController = TextEditingController(text: data.studentName);
    final emailController = TextEditingController(text: data.email);
    final progController = TextEditingController(text: data.programme);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.w800)),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Full Name')),
              const SizedBox(height: 12),
              TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email Address')),
              const SizedBox(height: 12),
              TextField(controller: progController, decoration: const InputDecoration(labelText: 'Programme')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              setState(() {
                data.studentName = nameController.text;
                data.email = emailController.text;
                data.programme = progController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!'), behavior: SnackBarBehavior.floating),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
