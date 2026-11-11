import 'package:cloud_firestore/cloud_firestore.dart';

/// Lost or found report, stored at lostFound/{id}. OWNER: Member 3.
class LostFoundReport {
  final String id;
  final String reporterId;
  final String reporterName;
  final String type; // 'lost' or 'found'
  final String title;
  final String description;
  final String category;
  final String location;
  final String contactNote; // how to reach the reporter
  final String status; // 'open', 'claimed' or 'returned'
  final String claimedBy; // uid, empty if nobody
  final DateTime createdAt;

  const LostFoundReport({
    required this.id,
    required this.reporterId,
    required this.reporterName,
    required this.type,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.contactNote,
    required this.status,
    required this.claimedBy,
    required this.createdAt,
  });

  factory LostFoundReport.fromMap(String id, Map<String, dynamic> m) =>
      LostFoundReport(
        id: id,
        reporterId: m['reporterId'] as String? ?? '',
        reporterName: m['reporterName'] as String? ?? '',
        type: m['type'] as String? ?? 'lost',
        title: m['title'] as String? ?? '',
        description: m['description'] as String? ?? '',
        category: m['category'] as String? ?? 'Other',
        location: m['location'] as String? ?? '',
        contactNote: m['contactNote'] as String? ?? '',
        status: m['status'] as String? ?? 'open',
        claimedBy: m['claimedBy'] as String? ?? '',
        createdAt: (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  /// For creating a NEW document. When editing, use update() with changed
  /// fields only.
  Map<String, dynamic> toMap() => {
        'reporterId': reporterId,
        'reporterName': reporterName,
        'type': type,
        'title': title,
        'description': description,
        'category': category,
        'location': location,
        'contactNote': contactNote,
        'status': status,
        'claimedBy': claimedBy,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
