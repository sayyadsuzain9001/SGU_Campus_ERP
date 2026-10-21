import 'package:flutter/material.dart';
import '../shared/module_pages.dart';
import '../../models/models.dart';

class TeacherCalendarPage extends StatelessWidget {
  const TeacherCalendarPage({super.key});
  @override
  Widget build(BuildContext context) => const GenericModulePage(title: 'Calendar', role: UserRole.teacher);
}
