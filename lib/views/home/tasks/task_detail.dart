import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../../models/task.dart';
import '../../app_bar.dart';
import '../../theme.dart';

class TaskDetail extends HookConsumerWidget {
  const TaskDetail(this.task, {Key? key}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final titleController = useTextEditingController(text: task.title);
    final subjectController = useTextEditingController(text: task.subject);
    final notesController = useTextEditingController(text: task.notes);

    useEffect(() {
      titleController.addListener(() => task.update(title: titleController.text));
      subjectController.addListener(() => task.update(subject: subjectController.text));
      notesController.addListener(() => task.update(notes: notesController.text));
    });

    return Scaffold(
      appBar: AppAppBar.withWidget(
        titleWidget: Row(
          children: [
            Expanded(
              child: TextField(
                controller: titleController,
                style: Theme.of(context).textTheme.headline6,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
              ),
            ),
            IconButton(
              splashRadius: 16,
              iconSize: 32,
              icon: Icon(
                Icons.circle_rounded,
                color: theme.taskPriorityColors[task.priority],
              ),
              onPressed: () {
                final newIndex = (task.priority.index - 1) % TaskPriority.values.length;
                task.update(priority: TaskPriority.values[newIndex]);
              },
            ),
          ],
        ),
        showProfile: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
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
                text: 'Due ${task.dueDateTime.format('d MMMM')}',
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
                  initialDate: task.dueDateTime.dateTime,
                  firstDate: DateTime.now(),
                  lastDate: Jiffy(DateTime.now()).add(years: 5).dateTime,
                );
                if (dateTime != null) {
                  await task.update(dueDateTime: Jiffy(dateTime));
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
        ],
      ),
    );
  }
}
