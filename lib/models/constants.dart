/// Shared names. Use these constants, never type the strings by hand.
class Collections {
  static const users = 'users';
  static const listings = 'listings'; // Member 2
  static const lostFound = 'lostFound'; // Member 3
  static const activity = 'activity'; // Member 3 owns, Member 2 also writes
}

const List<String> listingCategories = [
  'Textbooks', 'Electronics', 'Furniture', 'Clothes', 'Appliances', 'Other',
];
const List<String> listingConditions = ['New', 'Like new', 'Good', 'Fair'];
const String listingAvailable = 'available';
const String listingSold = 'sold';

const List<String> lostFoundCategories = [
  'Phone', 'ID card', 'Laptop', 'Charger', 'Bottle', 'Keys', 'Other',
];
const String reportLost = 'lost';
const String reportFound = 'found';
const String reportOpen = 'open';
const String reportClaimed = 'claimed';
const String reportReturned = 'returned';

class ActivityTypes {
  static const listingPosted = 'listing_posted';
  static const listingSold = 'listing_sold';
  static const reportPosted = 'report_posted';
  static const reportResolved = 'report_resolved';
}
