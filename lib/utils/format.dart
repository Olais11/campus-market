/// Shared formatting helpers used by Member 2 and Member 3.
const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// 11 Nov 2026
String formatDate(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

/// Rs 450
String formatPrice(double p) => 'Rs ${p.toStringAsFixed(0)}';
