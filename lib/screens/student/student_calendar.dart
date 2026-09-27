import 'package:flutter/material.dart';
import '../../widgets/calendar_widget.dart';
import '../../widgets/common.dart';
import '../shared/calendar.dart';

class StudentCalendarPage extends StatelessWidget {
  const StudentCalendarPage({super.key});
  @override
  Widget build(BuildContext context) => PageContainer(title: 'Calendar', subtitle: 'Your classes, assessments and campus events.', actions: [FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CalendarPage())), icon: const Icon(Icons.add), label: const Text('Add Event'))], child: LayoutBuilder(builder: (_, constraints) => constraints.maxWidth >= 900 ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Expanded(flex: 7, child: MiniCalendar()), const SizedBox(width: 14), const Expanded(flex: 3, child: UpcomingEvents())]) : const Column(children: [MiniCalendar(), SizedBox(height: 12), UpcomingEvents()])));
}
