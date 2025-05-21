import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Reusable AppBar style
  AppBar customAppBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color(0xFF1B263B),
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  // Reusable ListTile for settings sections
  Widget customListTile(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.white),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : Colors.white),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF0D1B2A), // Midnight Blue for consistent theme
      appBar: customAppBar('Profile & Settings'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Avatar & Name
          const Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Replace with user image
                ),
                SizedBox(height: 12),
                Text(
                  'John Doe',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'johndoe@email.com',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Edit Profile
          customListTile(Icons.edit, 'Edit Profile', () {
            // Navigate to edit profile screen
          }),

          // Notifications
          SwitchListTile(
            value: true,
            onChanged: (val) {
              // Handle toggle
            },
            secondary:
                const Icon(Icons.notifications_active, color: Colors.white),
            title: const Text('Notifications',
                style: TextStyle(color: Colors.white)),
            activeColor: Colors.blueAccent,
            inactiveThumbColor: Colors.grey,
          ),

          // Help Center
          customListTile(Icons.help_outline, 'Help Center', () {
            // Show help or navigate
          }),

          // Logout
          const Divider(height: 40),
          customListTile(Icons.logout, 'Logout', () {
            // FirebaseAuth.instance.signOut();  // Uncomment when integrated
            Navigator.pushReplacementNamed(context, '/login');
          }, isLogout: true),
        ],
      ),
    );
  }
}
