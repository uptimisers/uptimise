import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../models/task.dart';
import '../../alerts.dart';
import '../../app_bar.dart';

class TaskDetailPage extends HookConsumerWidget {
  const TaskDetailPage({Key? key, @PathParam('id') required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incompleteTasks = ref.watch(incompleteTasksProvider);
    final isRefreshing = useState<bool>(false);

    return Scaffold(
      appBar: const AppAppBar(
        title: '',
        showProfile: false,
      ),
      body: incompleteTasks.map(
        data: (incompleteTasks) {
          final task = incompleteTasks.value!
              .cast<Task?>()
              .singleWhere((task) => task!.id == id, orElse: () => null);
          if (task == null) {
            return const Center(child: Text('Task Not Found'));
          } else {
            // TODO: implement task detail
            return Center(child: Text(task.title));
          }
        },
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
      ),
    );
  }
}
