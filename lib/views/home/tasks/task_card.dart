import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/task.dart';
import '../../router/router.dart';
import '../../router/router.gr.dart';
import '../../theme.dart';

class TaskCard extends ConsumerWidget {
  const TaskCard(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);

    return Dismissible(
      key: ValueKey(task.id),
      onDismissed: (direction) => task.markAsCompleted(),
      child: Card(
        color: theme.taskPriorityColors[task.priority],
        child: InkWell(
          onTap: () => router.push(TaskDetailRoute(id: task.id)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DUE ${task.dueDateTime.format('d MMMM, h:mm a').toUpperCase()}',
                  style: Theme.of(context).textTheme.overline,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headline6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  task.subject,
                  style: Theme.of(context).textTheme.bodyText2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
