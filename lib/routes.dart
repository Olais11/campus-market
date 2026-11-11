/// ALL route names live here. Do not rename existing ones.
/// Detail/edit routes take the Firestore document id (a String) as
/// `arguments`: Navigator.pushNamed(context, Routes.listingDetail, arguments: id);
class Routes {
  // Auth (Member 1)
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const resetPassword = '/reset-password';

  // Home and marketplace (Member 2)
  static const listings = '/listings';
  static const listingDetail = '/listing-detail'; // arguments: String listingId
  static const postListing = '/post-listing';
  static const editListing = '/edit-listing'; // arguments: String listingId

  // Lost & Found (Member 3)
  static const lostFoundDetail = '/lost-found-detail'; // arguments: String reportId
  static const reportItem = '/report-item';
  static const editReport = '/edit-report'; // arguments: String reportId

  // Profile and settings (Member 4)
  static const editProfile = '/edit-profile';
  static const settings = '/settings';
}
