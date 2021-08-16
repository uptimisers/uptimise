import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../../../models/task.dart';
import '../../theme.dart';

class TaskDetail extends HookConsumerWidget {
  const TaskDetail(
      this.task, this.titleController, this.subjectController, this.dueDateTimeController,
      {Key? key})
      : super(key: key);

  final Task task;
  final TextEditingController titleController;
  final TextEditingController subjectController;
  final TextEditingController dueDateTimeController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    titleController.text = task.title;
    subjectController.text = task.subject;
    dueDateTimeController.text = task.dueDateTime.format('d MMMM, h:mm a');

    final theme = ref.watch(themeProvider);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        ListTile(
          leading: const SizedBox.shrink(),
          minLeadingWidth: 24,
          title: TextField(
            controller: titleController,
            style: Theme.of(context).textTheme.headline6,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
            ),
          ),
          trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.circle_rounded, color: theme.taskPriorityColors[task.priority])),
        ),
        ListTile(
          leading: const Icon(Icons.group_add_rounded),
          minLeadingWidth: 24,
          title: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Add people or groups',
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // TODO: Add sharing
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
          trailing: subjectController.text.isNotEmpty
              ? IconButton(
                  onPressed: subjectController.clear,
                  icon: const Icon(Icons.close_rounded),
                )
              : null, // TODO: Make this work
        ),
        ListTile(
          leading: const Icon(Icons.event_rounded),
          minLeadingWidth: 24,
          title: TextField(
            controller: dueDateTimeController,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Due date',
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: Jiffy(DateTime.now()).add(years: 5).dateTime,
              );
              // showTimePicker(context: context, initialTime: TimeOfDay.now());
              // TODO: Add datetime picker
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.timer_rounded),
          minLeadingWidth: 24,
          title: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Duration',
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // TODO: Add duration selection
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.schedule_rounded),
          minLeadingWidth: 24,
          title: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Add to schedule',
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // TODO: Add scheduling
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.repeat_rounded),
          minLeadingWidth: 24,
          title: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Repeat',
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // TODO: Add repeat frequency
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.attachment_rounded),
          minLeadingWidth: 24,
          title: TextField(
            style: Theme.of(context).textTheme.bodyText1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Add file',
            ),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              // TODO: Add attachment
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
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
    );
  }
}
