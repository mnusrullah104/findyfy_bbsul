import 'package:child_missing_app1/theme/colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Possible Match Found",
        "message": "Our system found a child matching your report.",
        "time": "5 mins ago"
      },
      {
        "title": "New Found Child Report",
        "message": "Someone reported a child found near Lahore.",
        "time": "1 hour ago"
      },
      {
        "title": "Reminder",
        "message": "Please update status of your missing child report.",
        "time": "Yesterday"
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No new notifications.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: AppColors.textSecondary,
                  child: ListTile(
                    leading: const Icon(Icons.notifications_active,
                        color: AppColors.primary),
                    title: Text(
                      notif['title']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    subtitle: Text(
                      notif['message']!,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      notif['time']!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
