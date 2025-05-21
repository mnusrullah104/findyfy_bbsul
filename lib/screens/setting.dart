import 'package:child_missing_app1/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class settingscreen extends StatefulWidget {
  const settingscreen({super.key});

  @override
  State<settingscreen> createState() => _settingscreenState();
}

class _settingscreenState extends State<settingscreen> {
  bool _notificationsEnabled = true;
  final bool _darkMode = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error signing out')),
      );
    }
  }

  void _showNotificationPopup(bool isEnabled) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              isEnabled ? "Notifications Enabled" : "Notifications Disabled"),
          content: Text(isEnabled
              ? "You will now receive notifications."
              : "Notifications have been turned off."),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.account_circle,
                size: 36, color: AppColors.primary),
            title: Text(user?.email ?? "Guest User"),
            subtitle: const Text("Logged in"),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text("Enable Notifications"),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
              _showNotificationPopup(_notificationsEnabled); // Show the popup
            },
            secondary: const Icon(Icons.notifications),
            activeColor:
                AppColors.primary, // Custom color for the notification switch
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: const Text("English (default)"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Multi-language coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy"),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Privacy Policy"),
                  content: const Text(
                    "We respect your privacy. This app does not share your data with third parties.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Close"),
                    )
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            subtitle: const Text("Findify v1.0. Helping families reconnect."),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.black),
            title: const Text("Sign Out",
                style: TextStyle(color: AppColors.black)),
            onTap: _signOut,
          ),
        ],
      ),
    );
  }
}
