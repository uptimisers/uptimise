import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../services/log_service.dart';
import 'theme.dart';

/// Shows a dialog for an unexpected error and logs it.
Future<void> showErrorDialog(
    BuildContext context, Object exception, StackTrace stack, WidgetRef ref) async {
  final log = ref.read(loggerProvider);
  final theme = ref.read(themeProvider);

  final id = const Uuid().v4();
  log.e('An error occured.', exception, stack, [DiagnosticsProperty('id', id)]);

  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Oh no!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('An error occured. Try again?'),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: BoxConstraints.loose(const Size.fromHeight(160)),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Text(
                  'ID:\u{00A0}$id'.replaceAll('-', '\u{2011}'),
                  style: TextStyle(
                    color: theme.foregroundAccented,
                    fontSize: 11,
                    fontFamily: 'NotoMono',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Clipboard.setData(ClipboardData(text: id)),
          child: const Text('Copy ID'),
        ),
        ElevatedButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Dismiss'),
        ),
      ],
    ),
  );
}

/// Shows a dialog for a forseeable exception and logs it.
Future<void> showExceptionDialog(
    BuildContext context, String message, Object exception, StackTrace stack, WidgetRef ref) async {
  final log = ref.read(loggerProvider);

  // ignore: cascade_invocations
  log.w(message, exception, stack);

  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('( ≧Д≦)', style: TextStyle(fontWeight: FontWeight.w900)),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Dismiss'),
        ),
      ],
    ),
  );
}
