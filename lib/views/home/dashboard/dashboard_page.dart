import 'package:flutter/material.dart';

import '../home_page.dart';

class DashboardPage extends StatelessWidget with HomeTabPage {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  String get title => 'Dashboard';

  @override
  IconData get iconData => Icons.dashboard_rounded;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Dashboard'));
  }
}
