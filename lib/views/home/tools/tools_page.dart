import 'package:flutter/material.dart';

import '../home_page.dart';

class ToolsPage extends StatelessWidget with HomeTabPage {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  String get title => 'Tools';

  @override
  IconData get iconData => Icons.handyman_rounded;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Tools'));
  }
}
