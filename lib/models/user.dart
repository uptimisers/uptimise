import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';

import '../services/auth_service.dart';
import 'task.dart';

final userProvider = Provider<AppUser?>((ref) {
  final authUser = ref.watch(authProvider);
  return authUser != null ? AppUser(authUser) : null;
});

AutoDisposeStreamProvider<List<State>> _createDocsProvider<State>({
  required Query query,
  required State Function(DocumentSnapshot) map,
}) {
  return StreamProvider.autoDispose<List<State>>((ref) {
    return query.snapshots().asyncMap((_) async {
      final snapshot = await query.get();
      return snapshot.docs.map(map).toList();
    });
  });
}

class AppUser {
  // ignore: prefer_initializing_formals
  AppUser(auth.User authUser) : info = authUser;

  final auth.User info;

  DocumentReference get _doc => FirebaseFirestore.instance.collection('users').doc(info.uid);

  late final incompleteTasksProvider = _createDocsProvider<Task>(
    query: _doc.collection('tasks').where('isCompleted', isEqualTo: false),
    map: (doc) => Task.fromDoc(doc),
  );

  Future<void> createTask({
    required String title,
    required String subject,
    required Jiffy dueDateTime,
    required TaskPriority priority,
  }) =>
      Task.create(
        _doc.collection('tasks'),
        title: title,
        subject: subject,
        dueDateTime: dueDateTime,
        priority: priority,
      );
}
