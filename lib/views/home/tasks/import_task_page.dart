import 'package:flutter/material.dart';
import 'package:googleapis/classroom/v1.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../services/auth_service.dart';
import '../../app_bar.dart';

class Item {
  Item({
    required this.headerValue,
    required this.expandedList,
    this.isExpanded = true, // TODO
  });

  String headerValue;
  List<CourseWork> expandedList;
  bool isExpanded;
}

class ImportTaskPage extends ConsumerWidget {
  const ImportTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider.notifier);
    if (auth.classroomApi == null) {
      auth.classroomInit();
    }

    Future<List<Item>> generateCourses() async {
      final courses = await auth.classroomApi!.courses.list(pageSize: 5); // TODO: lazy (pageSize)
      final list = <Item>[];
      for (final course in courses.courses!) {
        print(course.name!);
        final courseWork = await auth.classroomApi!.courses.courseWork
            .list(course.id!, pageSize: 5); // TODO: lazy (pageSize)
        if (courseWork.courseWork != null) {
          list.insert(
              list.length, Item(headerValue: course.name!, expandedList: courseWork.courseWork!));
        }
      }
      return list;
    }

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Import Task',
        showProfile: false,
      ),
      body: FutureBuilder(
        future: generateCourses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final _data = snapshot.data! as List<Item>;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: ExpansionPanelList(
                  children: _data.map<ExpansionPanel>(
                    (item) {
                      return ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(item.headerValue),
                          );
                        },
                        body: Column(
                          children: [
                            for (var work in item.expandedList)
                              ListTile(
                                title: Text(work.title!),
                              )
                          ],
                        ),
                        isExpanded: item.isExpanded,
                      );
                    },
                  ).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
