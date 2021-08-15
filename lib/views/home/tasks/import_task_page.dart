import 'package:flutter/material.dart';

import '../../app_bar.dart';

class ImportTaskPage extends StatelessWidget {
  const ImportTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Import Task',
        showProfile: false,
      ),
      body: Center(child: Text('Import Task')),
    );
  }
}
