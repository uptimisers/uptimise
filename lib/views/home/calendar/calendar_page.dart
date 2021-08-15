import 'package:flutter/material.dart';

import '../home_page.dart';

class CalendarPage extends StatelessWidget with HomeTabPage {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  String get title => 'Calendar';

  @override
  IconData get iconData => Icons.calendar_today_rounded;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Calendar'));
  }
}
