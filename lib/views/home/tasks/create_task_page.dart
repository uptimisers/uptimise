import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../../models/task.dart';
import '../../../models/user.dart';
import '../../app_bar.dart';
import '../../router/router.dart';
import '../../theme.dart';

class CreateTaskPage extends HookConsumerWidget {
  const CreateTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);

    final titleController = useTextEditingController();
    final subjectController = useTextEditingController();
    final notesController = useTextEditingController();

    final priority = useState<TaskPriority>(TaskPriority.low);
    final dueDateTime = useState<Jiffy>(Jiffy());

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Create Task',
        showProfile: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          ListTile(
            title: TextField(
              controller: titleController,
              style: Theme.of(context).textTheme.headline6,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
            ),
            trailing: IconButton(
              splashRadius: 16,
              iconSize: 32,
              icon: Icon(
                Icons.circle_rounded,
                color: theme.taskPriorityColors[priority.value],
              ),
              onPressed: () {
                final newIndex = (priority.value.index - 1) % TaskPriority.values.length;
                priority.value = TaskPriority.values[newIndex];
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.style_rounded),
            minLeadingWidth: 24,
            title: TextField(
              controller: subjectController,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Subject',
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.event_rounded),
            minLeadingWidth: 24,
            title: TextField(
              controller: TextEditingController(
                text: 'Due ${dueDateTime.value.format('d MMMM')}',
              ),
              style: Theme.of(context).textTheme.bodyText1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Due date',
              ),
              enableInteractiveSelection: false,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final dateTime = await showDatePicker(
                  context: context,
                  initialDate: dueDateTime.value.dateTime,
                  firstDate: DateTime.now(),
                  lastDate: Jiffy(DateTime.now()).add(years: 5).dateTime,
                );
                if (dateTime != null) {
                  dueDateTime.value = Jiffy(dateTime);
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.repeat_rounded),
            minLeadingWidth: 24,
            title: TextField(
              controller: TextEditingController(
                text: 'Does not repeat',
              ),
              style: Theme.of(context).textTheme.bodyText1,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              enableInteractiveSelection: false,
              onTap: () {
                // TODO: setup repeat and make it show a multiple-choice dialog
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: notesController,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add note',
              ),
              minLines: 10,
              maxLines: 50,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                user.createTask(
                  title: titleController.text,
                  subject: subjectController.text,
                  dueDateTime: dueDateTime.value,
                  priority: priority.value,
                );
                router.pop();
              },
              child: const Text('Create'),
            ),
          ),
        ],
      ),
    );
  }
}
