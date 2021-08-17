import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app_bar.dart';
import '../theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      appBar: const AppAppBar(
        title: 'Settings',
        showProfile: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SettingsGroup(
            iconData: Icons.language_rounded,
            title: 'Language',
            children: [
              ListTile(
                title: Text(
                  'English (UK)', // TODO
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: theme.primary,
                ),
                onTap: () {
                  // TODO: show language selection dialog
                },
              ),
            ],
          ),
          SettingsGroup(
            iconData: Icons.style_rounded,
            title: 'Appearance',
            children: [
              SwitchListTile(
                title: Text(
                  'Dark Mode',
                  style: Theme.of(context).textTheme.headline6,
                ),
                value: theme.brightness == Brightness.dark,
                onChanged: (value) {
                  // TODO: toggle dark mode
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsGroup extends ConsumerWidget {
  const SettingsGroup({
    Key? key,
    required this.iconData,
    required this.title,
    required this.children,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: Icon(
            iconData,
            color: theme.foreground,
            size: 32,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Card(
          color: theme.backgroundAccented,
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ...children,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
