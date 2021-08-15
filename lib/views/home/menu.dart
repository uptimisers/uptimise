import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../router/router.dart';
import '../router/router.gr.dart';
import '../theme.dart';

Future<void> showHomeMenu(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeProvider);
      final router = ref.watch(routerProvider);

      return SimpleDialog(
        title: Center(
          child: Text(
            'Uptimise',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: theme.primary,
            ),
          ),
        ),
        children: [
          ListTile(
            leading: Icon(
              Icons.person_rounded,
              color: theme.foreground,
            ),
            title: const Text('Your profile'),
            onTap: () {
              Navigator.of(context).pop();
              router.push(const ProfileRoute());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings_rounded,
              color: theme.foreground,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              router.push(const SettingsRoute());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_rounded,
              color: theme.foreground,
            ),
            title: const Text('About Uptimise'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: show about dialog
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help_rounded,
              color: theme.foreground,
            ),
            title: const Text('Help and feedback'),
            onTap: () {
              Navigator.of(context).pop();
              // TOOD: open help & feedback url
            },
          ),
        ],
      );
    }),
  );
}
