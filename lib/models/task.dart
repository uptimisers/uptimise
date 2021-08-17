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
    required this.notes,
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
        notes = snapshot.get('notes') as String,
        isCompleted = snapshot.get('isCompleted') as bool;

  final DocumentReference doc;
  final String id;
  final String title;
  final String subject;
  final Jiffy dueDateTime;
  final TaskPriority priority;
  final String notes;
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
      'notes': '',
      'isCompleted': false,
    });
    return Task.fromDoc(await doc.get());
  }

  Future<void> update({
    String? title,
    String? subject,
    Jiffy? dueDateTime,
    TaskPriority? priority,
    String? notes,
  }) async {
    await doc.update({
      if (title != null) 'title': title,
      if (subject != null) 'subject': subject,
      if (dueDateTime != null) 'dueDateTime': dueDateTime.dateTime,
      if (priority != null) 'priority': priority.index,
      if (notes != null) 'notes': notes,
    });
  }

  Future<void> markAsCompleted() async {
    await doc.update({'isCompleted': true});
  }
}
