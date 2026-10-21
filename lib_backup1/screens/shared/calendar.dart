import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(backgroundColor:AppTheme.bg,appBar:AppBar(title:const Text('Calendar')),body:SingleChildScrollView(padding:const EdgeInsets.all(20),child:Center(child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1280),child:Column(children:[Row(children:[const Text('September 2026',style:TextStyle(fontSize:24,fontWeight:FontWeight.w800,color:AppTheme.navy)),const Spacer(),OutlinedButton(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Today selected.'))),child:const Text('Today')),const SizedBox(width:8),FilledButton.icon(onPressed:()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Add event form opened.'))),icon:const Icon(Icons.add),label:const Text('Add Event'))]),const SizedBox(height:14),const Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Expanded(flex:7,child:MiniCalendar()),SizedBox(width:14),Expanded(flex:3,child:UpcomingEvents())])])))));
}
