import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/task.dart';
import '../../../models/user.dart';
import '../../alerts.dart';
import '../../app_bar.dart';
import 'task_detail.dart';

class TaskDetailPage extends HookConsumerWidget {
  const TaskDetailPage({Key? key, @PathParam('id') required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final incompleteTasks = ref.watch(user.incompleteTasksProvider);
    final isRefreshing = useState<bool>(false);

    return incompleteTasks.map(
      data: (incompleteTasks) {
        final task = incompleteTasks.value
            .cast<Task?>()
            .singleWhere((task) => task!.id == id, orElse: () => null);
        if (task == null) {
          return const Scaffold(
            appBar: AppAppBar(
              title: '',
              showProfile: false,
            ),
            body: Center(child: Text('Task Not Found')),
          );
        } else {
          return TaskDetail(task);
        }
      },
      loading: (_) => const Center(child: CircularProgressIndicator()),
      error: (e) {
        WidgetsBinding.instance!.scheduleFrameCallback((_) {
          showErrorDialog(context, e.error, e.stackTrace ?? StackTrace.current, ref);
        });
        return Scaffold(
          appBar: const AppAppBar(
            title: '',
            showProfile: false,
          ),
          body: Center(
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: !isRefreshing.value
                  ? () {
                      isRefreshing.value = true;
                      ref.refresh(user.incompleteTasksProvider);
                      isRefreshing.value = false;
                    }
                  : null,
            ),
          ),
        );
      },
    );
  }
}
