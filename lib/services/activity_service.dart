import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/activity_entry.dart';
import '../models/constants.dart';
import 'auth_service.dart';

/// Shared history log. Member 2 and Member 3 call log() whenever the user
/// posts or finishes something. Member 3's History screen uses myActivity().
class ActivityService {
  ActivityService._();
  static final ActivityService instance = ActivityService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Example: ActivityService.instance.log(
  ///   type: ActivityTypes.listingPosted, refId: id, title: 'Calculus book');
  Future<void> log({
    required String type,
    required String refId,
    required String title,
  }) async {
    final uid = AuthService.instance.currentUser?.uid;
    if (uid == null) return;
    await _db.collection(Collections.activity).add({
      'userId': uid,
      'type': type,
      'refId': refId,
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Newest first. Sorted in Dart so no Firestore index is needed.
  Stream<List<ActivityEntry>> myActivity() {
    final uid = AuthService.instance.currentUser?.uid;
    if (uid == null) return Stream.value(<ActivityEntry>[]);
    return _db
        .collection(Collections.activity)
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snap) {
      final list =
          snap.docs.map((d) => ActivityEntry.fromMap(d.id, d.data())).toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }
}
