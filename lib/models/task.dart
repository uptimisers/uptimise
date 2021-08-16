import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';

enum TaskPriority { veryHigh, high, low }

class Task {
  const Task({
    required this.doc,
    required this.id,
    required this.title,
    required this.subject,
    required this.dueDateTime,
    required this.priority,
    this.isCompleted = false,
  });

  Task.fromDoc(DocumentSnapshot snapshot)
      : doc = snapshot.reference,
        id = snapshot.id,
        title = snapshot.get('title') as String,
        subject = snapshot.get('subject') as String,
        dueDateTime = Jiffy((snapshot.get('dueDateTime') as Timestamp).toDate()),
        priority = TaskPriority.values[snapshot.get('priority') as int],
        isCompleted = snapshot.get('isCompleted') as bool;

  final DocumentReference doc;
  final String id;
  final String title;
  final String subject;
  final Jiffy dueDateTime;
  final TaskPriority priority;
  final bool isCompleted;

  static Future<Task> create(
    CollectionReference tasksRef, {
    required String title,
    required String subject,
    required Jiffy dueDateTime,
    required TaskPriority priority,
  }) async {
    final doc = await tasksRef.add(<String, dynamic>{
      'title': title,
      'subject': subject,
      'dueDateTime': dueDateTime.dateTime,
      'priority': priority.index,
      'isCompleted': false,
    });
    return Task(
      doc: doc,
      id: doc.id,
      title: title,
      subject: subject,
      dueDateTime: dueDateTime,
      priority: priority,
    );
  }

  Future<void> markAsCompleted() async {
    await doc.update({'isCompleted': true});
  }
}
