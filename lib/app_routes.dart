import 'package:flutter/widgets.dart';

import 'screens/auth/auth_routes.dart';
import 'screens/home/home_routes.dart';
import 'screens/lost_found/lost_found_routes.dart';
import 'screens/profile/profile_routes.dart';

/// Merges each member's own route map. Nobody edits this file.
/// Each member only edits their own *_routes.dart file.
final Map<String, WidgetBuilder> appRoutes = {
  ...authRoutes, // Member 1
  ...homeRoutes, // Member 2
  ...lostFoundRoutes, // Member 3
  ...profileRoutes, // Member 4
};
