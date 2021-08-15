import 'package:flutter/material.dart';

import '../../app_bar.dart';

class StartSessionPage extends StatelessWidget {
  const StartSessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Start Session',
        showProfile: false,
      ),
      body: Center(child: Text('Start Session')),
    );
  }
}
