import 'package:flutter/material.dart';

import '../../app_bar.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Create Task',
        showProfile: false,
      ),
      body: Center(child: Text('Create Task')),
    );
  }
}
