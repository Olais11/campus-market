import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

/// STUB. OWNER: Member 4. Replace the body with the real profile.
/// Keep the class name ProfileScreen, the const constructor and a working
/// log out button (Member 1's logout is tested from here).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signed in as ${user?.email ?? ''}'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => AuthService.instance.logout(),
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
