import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';

class Rest {
  const Rest({required this.startDateTime, required this.endDateTime});

  Rest.fromMap(Map<String, dynamic> map)
      : startDateTime = Jiffy((map['startDateTime'] as Timestamp).toDate()),
        endDateTime =
            map['endDateTime'] != null ? Jiffy((map['endDateTime'] as Timestamp).toDate()) : null;

  final Jiffy startDateTime;
  final Jiffy? endDateTime;

  Duration? get duration =>
      endDateTime != null ? startDateTime.dateTime.difference(endDateTime!.dateTime) : null;

  Rest copyWith({Jiffy? endDateTime}) => Rest(
        startDateTime: startDateTime,
        endDateTime: endDateTime,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'startDateTime': startDateTime,
        'endDateTime': endDateTime,
      };
}

class Session {
  const Session({
    required this.doc,
    required this.id,
    required this.startDateTime,
    this.endDateTime,
    this.rests = const [],
  });

  Session.fromDoc(DocumentSnapshot snapshot)
      : doc = snapshot.reference,
        id = snapshot.id,
        startDateTime = Jiffy((snapshot.get('startDateTime') as Timestamp).toDate()),
        endDateTime = snapshot.get('endDateTime') != null
            ? Jiffy((snapshot.get('endDateTime') as Timestamp).toDate())
            : null,
        rests = (snapshot.get('rests') as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((map) => Rest.fromMap(map))
            .toList();

  final DocumentReference doc;
  final String id;
  final Jiffy startDateTime;
  final Jiffy? endDateTime;
  final List<Rest> rests;

  bool get isBreak => rests.any((rest) => rest.endDateTime != null);

  static Future<Session> start(CollectionReference sessionsRef) async {
    final doc = await sessionsRef.add(<String, dynamic>{
      'startDateTime': Jiffy().dateTime,
      'endDateTime': null,
      'rests': const <Rest>[],
    });
    return Session.fromDoc(await doc.get());
  }

  Future<void> end() async {
    if (isBreak) {
      final restIndex = rests.indexWhere((rest) => rest.endDateTime != null);
      rests[restIndex] = rests[restIndex].copyWith(endDateTime: endDateTime);
      await uploadBreaks();
    }
    await doc.update({'endDateTime': Jiffy().dateTime});
  }

  Future<void> uploadBreaks() async {
    await doc.update({'rests': rests.map((rest) => rest.toMap()).toList()});
  }
}
