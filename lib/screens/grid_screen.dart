import 'package:child_missing_app1/screens/fount_detail.dart';
import 'package:child_missing_app1/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
  static Widget buildHoverButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Function() onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showWaitingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
            SizedBox(width: 20),
            Expanded(child: Text("Waiting for the model...")),
          ],
        ),
      );
    },
  );

  // Simulate a delay (e.g., model processing)
  Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pop(); // Close the dialog
  });
}

void _showSupportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Support'),
      content: const Text(
        'If you lost or found an item, please reach out to our support team at support@findify.app.\n\nWe are here to help!',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}

class _GridScreenState extends State<GridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Vibrant buttons in grid layout
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      GridScreen.buildHoverButton(
                        context,
                        icon: Icons.report,
                        label: 'Report Child',
                        onTap: () =>
                            Navigator.pushNamed(context, '/report_missing'),
                      ),
                      GridScreen.buildHoverButton(
                        context,
                        icon: Icons.person_search,
                        label: 'Found Child Details',
                        onTap: () =>
                            Navigator.pushNamed(context, '/found_child'),
                      ),
                      GridScreen.buildHoverButton(
                        context,
                        icon: Icons.info_outline,
                        label: 'Found Details',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return FoundDetailPage();
                          }));
                        },
                      ),
                      GridScreen.buildHoverButton(
                        context,
                        icon: Icons.photo_camera,
                        label: 'Search by Photo',
                        onTap: () => _showWaitingDialog(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login'); // after logout
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong during sign out')),
      );
    }
  }
}
