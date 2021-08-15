import 'package:flutter/material.dart';

import '../app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Settings',
        showProfile: false,
      ),
      body: Center(child: Text('Settings')),
    );
  }
}
