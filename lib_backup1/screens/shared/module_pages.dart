import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

class GenericModulePage extends StatelessWidget {
  final String title;
  final UserRole role;
  const GenericModulePage({super.key, required this.title, required this.role});

  @override
  Widget build(BuildContext context) => PageContainer(title: title, subtitle: _subtitle, child: _content());

  String get _subtitle => switch (title) {
        'Timetable' => 'View your academic schedule and room details.',
        'Academic Progress' => 'Track CGPA, credits and semester performance.',
        'Results' => 'Review published semester results.',
        'Finance' || 'Fee Summary' => 'Manage fee balances, payments and receipts.',
        'Notifications' => 'Important academic and campus updates.',
        'Messages' => 'Communication with university users.',
        'Requests' => 'Submit and track university service requests.',
        _ => 'Manage $title from the university portal.',
      };

  Widget _content() {
    if (title == 'Academic Progress') return const _ProgressContent();
    if (title == 'Finance' || title == 'Fee Summary' || title == 'Payment History' || title == 'Receipts') return const _FinanceContent();
    if (title == 'Timetable') return const _TimetableContent();
    if (title == 'Results') return const _ResultsContent();
    return Column(children: [
      EmptyActionCard(icon: Icons.dashboard_customize_outlined, title: title, subtitle: 'This module is ready for live data integration.'),
      const SizedBox(height: 12),
      EmptyActionCard(icon: Icons.filter_list_outlined, title: 'Filters and search', subtitle: 'Filter records by course, status, date or category.'),
      const SizedBox(height: 12),
      EmptyActionCard(icon: Icons.history_outlined, title: 'Recent activity', subtitle: 'Recent actions and status changes will appear here.'),
    ]);
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent();
  @override
  Widget build(BuildContext context) => Column(children: [
    LayoutBuilder(builder: (_, c) => GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: c.maxWidth > 700 ? 3 : 1, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.8, children: const [
      _Metric('CGPA', '8.35'), _Metric('Credits Earned', '96'), _Metric('Semester', '6'),
    ])),
    const SizedBox(height: 18),
    const SectionHeader('Semester Performance'), const SizedBox(height: 8),
    Card(child: Column(children: const [
      _ProgressRow('Machine Learning', .86), _ProgressRow('Deep Learning', .82), _ProgressRow('Mobile Application', .88), _ProgressRow('Computer Vision', .86),
    ])),
  ]);
}

class _Metric extends StatelessWidget {
  final String label; final String value;
  const _Metric(this.label, this.value);
  @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(18), child: Row(children: [Expanded(child: Text(label, style: const TextStyle(color: AppTheme.muted))), Text(value, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: AppTheme.navy))])));
}

class _ProgressRow extends StatelessWidget {
  final String label; final double value;
  const _ProgressRow(this.label, this.value);
  @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 4), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))), Text('${(value * 100).round()}%', style: const TextStyle(color: AppTheme.muted))]), const SizedBox(height: 6), LinearProgressIndicator(value: value, minHeight: 6, backgroundColor: AppTheme.border, color: AppTheme.red)]));
}

class _FinanceContent extends StatelessWidget {
  const _FinanceContent();
  @override Widget build(BuildContext context) => Column(children: [
    LayoutBuilder(builder: (_, c) => GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: c.maxWidth > 700 ? 3 : 1, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.5, children: const [_Metric('Total Fees', 'RM 18,000'), _Metric('Paid', 'RM 15,000'), _Metric('Outstanding', 'RM 3,000')])) ,
    const SizedBox(height: 18), const SectionHeader('Payment History'), const SizedBox(height: 8), Card(child: Column(children: const [_FinanceRow('Semester 6 Fee', '25 Sep 2026', 'RM 3,000'), _FinanceRow('Semester 5 Fee', '10 Feb 2026', 'RM 3,200'), _FinanceRow('Hostel Fee', '05 Jan 2026', 'RM 2,500')])),
  ]);
}

class _FinanceRow extends StatelessWidget { final String title,date,amount; const _FinanceRow(this.title,this.date,this.amount); @override Widget build(BuildContext context)=>ListTile(leading: const Icon(Icons.receipt_long_outlined,color:AppTheme.info),title:Text(title,style:const TextStyle(fontWeight:FontWeight.w700)),subtitle:Text(date),trailing:Text(amount,style:const TextStyle(fontWeight:FontWeight.w800))); }

class _TimetableContent extends StatelessWidget {
  const _TimetableContent();
  @override Widget build(BuildContext context) => Card(child: Column(children: const [
    _ClassRow('09:00 AM – 10:00 AM','Deep Learning','Lab 204'), _ClassRow('11:30 AM – 01:00 PM','Machine Learning','Room 305'), _ClassRow('02:00 PM – 04:00 PM','Computer Vision','Lab 101'), _ClassRow('04:30 PM – 05:30 PM','Project Discussion','Online'),
  ]));
}
class _ClassRow extends StatelessWidget { final String time,course,room; const _ClassRow(this.time,this.course,this.room); @override Widget build(BuildContext context)=>ListTile(leading:const Icon(Icons.schedule_outlined,color:AppTheme.info),title:Text(course,style:const TextStyle(fontWeight:FontWeight.w700)),subtitle:Text('$time • $room'),trailing:const Icon(Icons.chevron_right)); }

class _ResultsContent extends StatelessWidget {
  const _ResultsContent();
  @override Widget build(BuildContext context) => Column(children: [
    const Card(child: Padding(padding: EdgeInsets.all(20), child: Row(children: [Expanded(child: _ResultMetric('SGPA','8.42')), Expanded(child: _ResultMetric('CGPA','8.35')), Expanded(child: _ResultMetric('Credits','96'))]))),
    const SizedBox(height: 16), const SectionHeader('Semester 6 Results'), const SizedBox(height: 8),
    Card(child: Column(children: const [_ResultRow('Machine Learning','A'),_ResultRow('Deep Learning','A-'),_ResultRow('Computer Vision','A'),_ResultRow('Mobile Application Development','A')]))
  ]);
}
class _ResultMetric extends StatelessWidget { final String label,value; const _ResultMetric(this.label,this.value); @override Widget build(BuildContext context)=>Column(children:[Text(value,style:const TextStyle(fontSize:24,fontWeight:FontWeight.w800,color:AppTheme.navy)),Text(label,style:const TextStyle(color:AppTheme.muted))]); }
class _ResultRow extends StatelessWidget { final String subject,grade; const _ResultRow(this.subject,this.grade); @override Widget build(BuildContext context)=>ListTile(title:Text(subject,style:const TextStyle(fontWeight:FontWeight.w700)),trailing:StatusChip(grade,color:AppTheme.success)); }
