import 'package:flutter/widgets.dart';

import '../../routes.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';
import 'welcome_screen.dart';

// OWNER: Member 1
final Map<String, WidgetBuilder> authRoutes = {
  Routes.welcome: (_) => const WelcomeScreen(),
  Routes.login: (_) => const LoginScreen(),
  Routes.register: (_) => const RegisterScreen(),
  Routes.resetPassword: (_) => const ResetPasswordScreen(),
};
