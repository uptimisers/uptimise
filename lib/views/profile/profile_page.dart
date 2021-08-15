import 'package:flutter/material.dart';

import '../app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppAppBar(
        title: 'Profile',
        showProfile: false,
      ),
      body: Center(child: Text('Profile')),
    );
  }
}
