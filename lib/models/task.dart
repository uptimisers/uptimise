import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.subject,
    required this.dueDateTime,
    this.isCompleted = false,
  });

  Task.fromDoc(QueryDocumentSnapshot doc)
      : id = doc.id,
        title = doc.get('title') as String,
        subject = doc.get('subject') as String,
        dueDateTime = (doc.get('dueDateTime') as Timestamp).toDate(),
        isCompleted = doc.get('isCompleted') as bool;

  final String id;
  final String title;
  final String subject;
  final DateTime dueDateTime;
  final bool isCompleted;

  static Future<Task> create(
      WidgetRef ref, String title, String subject, DateTime dueDateTime) async {
    final userDoc = ref.read(userDocProvider);
    final doc = await userDoc!.collection('tasks').add(<String, dynamic>{
      'title': title,
      'subject': subject,
      'dueDateTime': dueDateTime,
      'isCompleted': false,
    });
    return Task(id: doc.id, title: title, subject: subject, dueDateTime: dueDateTime);
  }
}
