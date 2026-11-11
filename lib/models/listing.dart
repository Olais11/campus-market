import 'package:cloud_firestore/cloud_firestore.dart';

/// Marketplace listing, stored at listings/{id}. OWNER: Member 2.
class Listing {
  final String id;
  final String sellerId;
  final String sellerName;
  final String title;
  final String description;
  final String category;
  final String condition;
  final String status; // 'available' or 'sold'
  final double price;
  final DateTime createdAt;

  const Listing({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.title,
    required this.description,
    required this.category,
    required this.condition,
    required this.status,
    required this.price,
    required this.createdAt,
  });

  factory Listing.fromMap(String id, Map<String, dynamic> m) => Listing(
        id: id,
        sellerId: m['sellerId'] as String? ?? '',
        sellerName: m['sellerName'] as String? ?? '',
        title: m['title'] as String? ?? '',
        description: m['description'] as String? ?? '',
        category: m['category'] as String? ?? 'Other',
        condition: m['condition'] as String? ?? 'Good',
        status: m['status'] as String? ?? 'available',
        price: ((m['price'] as num?) ?? 0).toDouble(),
        createdAt: (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      );

  /// For creating a NEW document. When editing, use update() with only the
  /// fields that changed so createdAt and sellerId are never overwritten.
  Map<String, dynamic> toMap() => {
        'sellerId': sellerId,
        'sellerName': sellerName,
        'title': title,
        'description': description,
        'category': category,
        'condition': condition,
        'status': status,
        'price': price,
        'createdAt': FieldValue.serverTimestamp(),
      };
}
