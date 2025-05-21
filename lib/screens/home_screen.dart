// // import statements (do not change)
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:child_missing_app1/screens/found_child_screen.dart';
// import 'package:child_missing_app1/screens/fount_detail.dart';
// import 'package:child_missing_app1/screens/notification_screen.dart';
// import 'package:child_missing_app1/screens/report_missing_screen.dart';
// import 'package:child_missing_app1/screens/setting.dart';
// import 'package:child_missing_app1/theme/colors.dart';

// // HomeScreen class
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();

//   // Custom Hover Button for dashboard options
//   static Widget buildHoverButton(BuildContext context,
//       {required IconData icon,
//       required String label,
//       required Function() onTap}) {
//     return MouseRegion(
//       child: GestureDetector(
//         onTap: onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFFB2FEFA), Color(0xFF0ED2F7)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: const [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 8,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon,
//                   size: 46, color: const Color.fromARGB(255, 5, 18, 159)),
//               const SizedBox(height: 10),
//               Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main HomeScreen state class
// class _HomeScreenState extends State<HomeScreen> {
//   final AuthService _auth = AuthService();
//   int _selectedIndex = 0;

//   // Bottom navigation screens and content
//   final List<Map<String, dynamic>> _bottomScreens = [
//     {
//       'title': 'Findify',
//       'content': [
//         {
//           'icon': Icons.report,
//           'label': 'Report Lost\n Child',
//           'onTap': (BuildContext context) =>
//               Navigator.pushNamed(context, '/report_missing'),
//         },
//         {
//           'icon': Icons.person_search,
//           'label': 'Report Found\n Child',
//           'onTap': (BuildContext context) =>
//               Navigator.pushNamed(context, '/found_child'),
//         },
//         {
//           'icon': Icons.info_outline,
//           'label': 'All Found\n Cases',
//           'onTap': (BuildContext context) => Navigator.push(
//               context, MaterialPageRoute(builder: (_) => FoundDetailPage())),
//         },
//         {
//           'icon': Icons.photo_camera,
//           'label': 'Search by\n Photo',
//           'onTap': (BuildContext context) => _showWaitingDialog(context),
//         },
//       ],
//     },
//     {
//       'title': 'Notifications',
//       'screen': const NotificationScreen(),
//     },
//     {
//       'title': 'Settings',
//       'screen': const settingscreen(),
//     },
//   ];

//   // Drawer menu items
//   final List<Map<String, dynamic>> _drawerItems = [
//     {
//       'icon': Icons.home,
//       'label': 'Home',
//       'onTap': (BuildContext context) => Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const HomeScreen())),
//     },
//     {
//       'icon': Icons.report,
//       'label': 'Report Lost Child',
//       'onTap': (BuildContext context) => Navigator.push(context,
//           MaterialPageRoute(builder: (_) => const ReportMissingScreen())),
//     },
//     {
//       'icon': Icons.search,
//       'label': 'Found Child',
//       'onTap': (BuildContext context) => Navigator.push(
//           context, MaterialPageRoute(builder: (_) => const FoundChildScreen())),
//     },
//     {
//       'icon': Icons.contact_support,
//       'label': 'Support',
//       'onTap': (BuildContext context) => _showSupportDialog(context),
//     },
//   ];

//   // Tap event for bottom nav bar
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   // Loading dialog
//   static void _showWaitingDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         content: Row(
//           children: const [
//             CircularProgressIndicator(color: AppColors.primary),
//             SizedBox(width: 20),
//             Expanded(child: Text("Waiting for the model...")),
//           ],
//         ),
//       ),
//     );
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.of(context).pop();
//     });
//   }

//   // Support dialog
//   static void _showSupportDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Support'),
//         content: const Text(
//           'If you lost or found an item, please reach out to our support team at support@findify.app.\n\nWe are here to help!',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Build method
//   @override
//   Widget build(BuildContext context) {
//     final screenData = _bottomScreens[_selectedIndex];

//     return Scaffold(
//       // APP BAR with LOGO instead of text title
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//         elevation: 2,
//         title: SizedBox(
//           height: 200,
//           width: 200,
//           child: Image.asset(
//             'assets/appbar_logo.png', // Replace with your logo path
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),

//       // DRAWER SECTION
//       drawer: Drawer(
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color.fromARGB(255, 123, 183, 120), Color(0xFF0ED2F7)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Column(
//             children: [
//               DrawerHeader(
//                 child: Center(
//                   child: Image.asset(
//                     'assets/fyplogo.png',
//                     height: 100,
//                     width: 100,
//                   ),
//                 ),
//               ),
//               ..._drawerItems.map((item) {
//                 return ListTile(
//                   leading: Icon(item['icon'],
//                       color: const Color.fromARGB(255, 2, 41, 168)),
//                   title: Text(item['label'],
//                       style: const TextStyle(color: Colors.black)),
//                   onTap: () => item['onTap'](context),
//                 );
//               }),
//               const Spacer(),
//               ListTile(
//                 leading: const Icon(Icons.logout, color: Colors.black),
//                 title: const Text('Sign Out',
//                     style: TextStyle(color: Colors.black)),
//                 onTap: () => _auth.signOut(context),
//               ),
//             ],
//           ),
//         ),
//       ),

//       // BODY SECTION
//       body: screenData.containsKey('screen')
//           ? screenData['screen']
//           : SafeArea(
//               child: Container(
//                 color: const Color.fromARGB(255, 135, 205, 242),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     Column(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: Image.asset(
//                             'assets/oun.png',
//                             height: 130,
//                             width: 130,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           "  Lost & Found Child !",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w800,
//                             color: Color.fromARGB(221, 30, 19, 230),
//                             shadows: [
//                               Shadow(
//                                 blurRadius: 4,
//                                 color: Colors.black26,
//                                 offset: Offset(1, 1),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                         child: GridView.count(
//                           crossAxisCount:
//                               MediaQuery.of(context).size.width > 600 ? 3 : 2,
//                           crossAxisSpacing: 16,
//                           mainAxisSpacing: 16,
//                           children: (screenData['content'] as List)
//                               .map<Widget>((item) =>
//                                   HomeScreen.buildHoverButton(context,
//                                       icon: item['icon'],
//                                       label: item['label'],
//                                       onTap: () => item['onTap'](context)))
//                               .toList(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//       // BOTTOM NAVIGATION BAR
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: const Color.fromARGB(255, 6, 48, 138),
//         unselectedItemColor: const Color.fromARGB(255, 20, 84, 224),
//         backgroundColor: AppColors.primary,
//         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notification',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Setting',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Firebase Auth helper class
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> signOut(BuildContext context) async {
//     try {
//       await _auth.signOut();
//       Navigator.pushReplacementNamed(context, '/login');
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Something went wrong during sign out.')),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:child_missing_app1/screens/found_child_screen.dart';
import 'package:child_missing_app1/screens/fount_detail.dart';
import 'package:child_missing_app1/screens/notification_screen.dart';
import 'package:child_missing_app1/screens/report_missing_screen.dart';
import 'package:child_missing_app1/screens/setting.dart';
import 'package:child_missing_app1/theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static Widget buildHoverButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.indigo),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _bottomScreens = [
    {
      'title': 'Findify',
      'content': [
        {
          'icon': Icons.add_alert,
          'label': 'Report Lost Child',
          'onTap': (BuildContext context) =>
              Navigator.pushNamed(context, '/report_missing'),
        },
        {
          'icon': Icons.person_search,
          'label': 'Report Found Child',
          'onTap': (BuildContext context) =>
              Navigator.pushNamed(context, '/found_child'),
        },
        {
          'icon': Icons.info_outline,
          'label': 'All Found Cases',
          'onTap': (BuildContext context) => Navigator.push(
              context, MaterialPageRoute(builder: (_) => FoundDetailPage())),
        },
        {
          'icon': Icons.photo_camera,
          'label': 'Search by Photo',
          'onTap': (BuildContext context) => _showWaitingDialog(context),
        },
      ],
    },
    {
      'title': 'Notifications',
      'screen': const NotificationScreen(),
    },
    {
      'title': 'Settings',
      'screen': const settingscreen(),
    },
  ];

  final List<Map<String, dynamic>> _drawerItems = [
    {
      'icon': Icons.home,
      'label': 'Home',
      'onTap': (BuildContext context) => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen())),
    },
    {
      'icon': Icons.report,
      'label': 'Report Lost Child',
      'onTap': (BuildContext context) => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const ReportMissingScreen())),
    },
    {
      'icon': Icons.search,
      'label': 'Report Found Child',
      'onTap': (BuildContext context) => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const FoundChildScreen())),
    },
    {
      'icon': Icons.contact_support,
      'label': 'Support',
      'onTap': (BuildContext context) => _showSupportDialog(context),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static void _showWaitingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Row(
          children: const [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(width: 20),
            Expanded(child: Text("Analyzing the image...")),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  static void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Support'),
        content: const Text(
          'For any issues, please contact: support@findify.app',
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

  @override
  Widget build(BuildContext context) {
    final screenData = _bottomScreens[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 2,
        title: SizedBox(
          height: 170,
          width: 170,
          child: Image.asset('assets/appbar_logo.png', fit: BoxFit.contain),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFA1C4FD), Color(0xFFC2E9FB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    'assets/fyplogo.png',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              ..._drawerItems.map((item) {
                return ListTile(
                  leading: Icon(item['icon'], color: Colors.indigo),
                  title: Text(item['label'],
                      style: const TextStyle(color: Colors.black)),
                  onTap: () => item['onTap'](context),
                );
              }),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.black),
                title: const Text('Sign Out',
                    style: TextStyle(color: Colors.black)),
                onTap: () => _auth.signOut(context),
              ),
            ],
          ),
        ),
      ),
      body: screenData.containsKey('screen')
          ? screenData['screen']
          : SafeArea(
              child: Container(
                color: const Color.fromARGB(255, 232, 246, 253),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/oun.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Lost & Found Child",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 12),
                        child: GridView.count(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: (screenData['content'] as List)
                              .map<Widget>(
                                  (item) => HomeScreen.buildHoverButton(
                                        context,
                                        icon: item['icon'],
                                        label: item['label'],
                                        onTap: () => item['onTap'](context),
                                      ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo[800],
        unselectedItemColor: Colors.indigo[400],
        backgroundColor: AppColors.primary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error signing out.')),
      );
    }
  }
}
