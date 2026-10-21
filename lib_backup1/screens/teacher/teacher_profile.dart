import 'package:flutter/material.dart';
import '../shared/module_pages.dart';
import '../../models/models.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const GenericModulePage(title: 'Profile', role: UserRole.teacher);
}
