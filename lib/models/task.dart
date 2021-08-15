import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../services/auth_service.dart';

final incompleteTasksProvider = StreamProvider.autoDispose<List<Task>?>((ref) {
  final userDoc = ref.watch(userDocProvider);
  if (userDoc == null) {
    return Stream.value(null).asBroadcastStream();
  } else {
    ref.maintainState = true;
    final incompleteTasks = userDoc.collection('tasks').where('isCompleted', isEqualTo: false);
    return incompleteTasks.snapshots().asyncMap((_) async {
      final snapshot = await incompleteTasks.get();
      return snapshot.docs.map((doc) => Task.fromDoc(doc)).toList();
    }).asBroadcastStream();
  }
});

enum TaskPriority { veryHigh, high, low }

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.subject,
    required this.dueDateTime,
    required this.priority,
    this.isCompleted = false,
  });

  Task.fromDoc(QueryDocumentSnapshot doc)
      : id = doc.id,
        title = doc.get('title') as String,
        subject = doc.get('subject') as String,
        dueDateTime = Jiffy((doc.get('dueDateTime') as Timestamp).toDate()),
        priority = TaskPriority.values[doc.get('priority') as int],
        isCompleted = doc.get('isCompleted') as bool;

  final String id;
  final String title;
  final String subject;
  final Jiffy dueDateTime;
  final TaskPriority priority;
  final bool isCompleted;

  static Future<Task> create(
    WidgetRef ref, {
    required String title,
    required String subject,
    required Jiffy dueDateTime,
    required TaskPriority priority,
  }) async {
    final userDoc = ref.read(userDocProvider);
    final doc = await userDoc!.collection('tasks').add(<String, dynamic>{
      'title': title,
      'subject': subject,
      'dueDateTime': dueDateTime.dateTime,
      'priority': priority.index,
      'isCompleted': false,
    });
    return Task(
      id: doc.id,
      title: title,
      subject: subject,
      dueDateTime: dueDateTime,
      priority: priority,
    );
  }

  DocumentReference doc(WidgetRef ref) {
    return ref.read(userDocProvider)!.collection('tasks').doc(id);
  }

  Future<void> markAsCompleted(WidgetRef ref) async {
    await doc(ref).update({'isCompleted': true});
  }
}
