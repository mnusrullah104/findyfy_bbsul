import 'package:flutter/material.dart';

class FaceMatchScreen extends StatelessWidget {
  const FaceMatchScreen({super.key});

  AppBar customAppBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: const Color(0xFF1B263B),
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> matches = [
      {
        'name': 'Ahmed Ali',
        'confidence': 92,
        'imageUrl': 'https://via.placeholder.com/100'
      },
      {
        'name': 'Unknown',
        'confidence': 78,
        'imageUrl': 'https://via.placeholder.com/100'
      },
    ];

    return Scaffold(
      appBar: customAppBar('Face Match Results'),
      backgroundColor: const Color(0xFF0D1B2A), // Dark background
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Matching Results',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: matches.isEmpty
                  ? const Center(
                      child: Text(
                        'No Match Found 😔',
                        style: TextStyle(fontSize: 18, color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, index) {
                        final match = matches[index];
                        return Card(
                          color: const Color(0xFF2C3E50), // Card background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                match['imageUrl'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              match['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              'Match Confidence: ${match['confidence']}%',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.white60),
                            onTap: () {
                              // Later: navigate to detailed view
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
