import 'package:cloud_firestore/cloud_firestore.dart';

void addMissingChild({
  required String name,
  required int age,
  required String location,
  required String contactNumber,
  required String gender,
  required String imageUrl,
}) {
  FirebaseFirestore.instance.collection('missing_children').add({
    'name': name,
    'age': age,
    'location': location,
    'contact_number': contactNumber,
    'gender': gender,
    'image_url': imageUrl,
    'timestamp': FieldValue.serverTimestamp(),
  }).then((value) {
    print("Child Report Added");
  }).catchError((error) {
    print("Failed to add child: $error");
  });
}
