import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/task.dart';
import '../../alerts.dart';
import '../home_page.dart';
import 'task_card.dart';

class TasksPage extends HookConsumerWidget with HomeTabPage {
  const TasksPage({Key? key}) : super(key: key);

  @override
  String get title => 'Tasks';

  @override
  IconData get iconData => Icons.list_rounded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRefreshing = useState<bool>(false);

    return ref.watch(incompleteTasksProvider).map(
          data: (incompleteTasks) => incompleteTasks.value!.isEmpty
              ? Center(
                  child: Text(
                    'Congratulations, you cleared all your tasks!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              : ListView.builder(
                  itemCount: incompleteTasks.value!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: TaskCard(incompleteTasks.value![index]),
                  ),
                ),
          loading: (_) => const Center(child: CircularProgressIndicator()),
          error: (e) {
            showErrorDialog(context, e.error, e.stackTrace ?? StackTrace.current, ref);
            return IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: !isRefreshing.value
                  ? () {
                      isRefreshing.value = true;
                      ref.refresh(incompleteTasksProvider);
                      isRefreshing.value = false;
                    }
                  : null,
            );
          },
        );
  }
}
