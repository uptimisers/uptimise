import 'package:flutter/material.dart';

import '../home_page.dart';

class TasksPage extends StatelessWidget with HomeTabPage {
  const TasksPage({Key? key}) : super(key: key);

  @override
  String get title => 'Tasks';

  @override
  IconData get iconData => Icons.list_rounded;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Tasks'));
  }
}
