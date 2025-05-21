import 'package:child_missing_app1/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoundDetailPage extends StatefulWidget {
  const FoundDetailPage({super.key});

  @override
  _FoundDetailPageState createState() => _FoundDetailPageState();
}

class _FoundDetailPageState extends State<FoundDetailPage> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  // Firestore reference to the 'report_missing_child' collection
  final CollectionReference report_missing_child =
      FirebaseFirestore.instance.collection('report_missing_child');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text("Found Detail of the Child",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.background)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchQuery = searchController.text.trim().toLowerCase();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              cursorColor: AppColors.primary,
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: AppColors.primary)),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              // Correctly access Firestore collection 'report_missing_child'
              stream: FirebaseFirestore.instance
                  .collection('report_missing_child')
                  .where('name', isGreaterThanOrEqualTo: searchQuery)
                  .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator()); // Loading indicator
                }

                if (streamSnapshot.hasData &&
                    streamSnapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: documentSnapshot['imageurl'] != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      documentSnapshot['imageurl']),
                                  radius: 30,
                                )
                              : Icon(Icons.person, size: 50),
                          title: Text(documentSnapshot['name'] ?? 'No Name',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text('Age: ${documentSnapshot['age'] ?? 'N/A'}'),
                              Text(
                                  'Gender: ${documentSnapshot['gernder'] ?? 'N/A'}'),
                              Text(
                                  'Contact: ${documentSnapshot['contact_number'] ?? 'N/A'}'),
                              Text(
                                  'Location: ${documentSnapshot['location'] ?? 'N/A'}'),
                              Text(
                                'Timestamp: ${documentSnapshot['timestamp']?.toDate().toString() ?? 'N/A'}',
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 15, 9, 205)),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text("No data available"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
