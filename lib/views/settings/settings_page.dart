import 'package:flutter/material.dart';

import '../app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dark = false;

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Settings',
        showProfile: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Language',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF3F6FF)),
              ),
              child: SizedBox(
                height: 32,
                child: Row(
                  children: const [
                    Text(
                      'English (UK)',
                      style: TextStyle(color: Color(0xFF3A90FF)),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF3A90FF),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Appearance',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFF3F6FF)),
              ),
              child: SizedBox(
                height: 32,
                child: Row(
                  children: [
                    const Text(
                      'Dark Mode',
                      style: TextStyle(color: Color(0xFF3A90FF)),
                    ),
                    const Spacer(),
                    Switch(
                      value: dark,
                      onChanged: (toggled) {
                        // TODO: dark theme toggling
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
