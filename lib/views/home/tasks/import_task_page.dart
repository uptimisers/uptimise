import 'package:flutter/material.dart';

import '../../app_bar.dart';

class ImportTaskPage extends StatelessWidget {
  const ImportTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(
        title: 'Import Task',
        showProfile: false,
      ),
      body: Center(
        child: Text(
          'coming soon',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
