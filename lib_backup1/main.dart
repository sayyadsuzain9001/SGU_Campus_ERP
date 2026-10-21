import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'navigation/app_shell.dart';

void main() => runApp(const SGUStudentCampusApp());

class SGUStudentCampusApp extends StatelessWidget {
  const SGUStudentCampusApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SGU Student Campus',
        theme: AppTheme.theme,
        home: const AppShell(),
      );
}
