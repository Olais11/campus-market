import 'package:cloud_firestore/cloud_firestore.dart';

/// One line of a user's history, stored at activity/{id}.
class ActivityEntry {
  final String id;
  final String userId;
  final String type; // see ActivityTypes in constants.dart
  final String refId; // id of the listing or report it is about
  final String title;
  final DateTime createdAt;

  const ActivityEntry({
    required this.id,
    required this.userId,
    required this.type,
    required this.refId,
    required this.title,
    required this.createdAt,
  });

  factory ActivityEntry.fromMap(String id, Map<String, dynamic> m) =>
      ActivityEntry(
        id: id,
        userId: m['userId'] as String? ?? '',
        type: m['type'] as String? ?? '',
        refId: m['refId'] as String? ?? '',
        title: m['title'] as String? ?? '',
        createdAt: (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );
}
