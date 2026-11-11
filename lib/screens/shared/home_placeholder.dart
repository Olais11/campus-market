import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

/// Temporary signed-in screen with logout. Member 4 replaces this with
/// the real navigation shell; Member 2 supplies the real home screen.
class HomePlaceholder extends StatelessWidget {
  const HomePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Market'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () => AuthService.instance.logout(),
          ),
        ],
      ),
      body: Center(child: Text('Signed in as ${user?.email ?? ''}')),
    );
  }
}
