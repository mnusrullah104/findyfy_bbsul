// import 'dart:io';
// import 'package:child_missing_app1/theme/colors.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'
//     show FieldValue, FirebaseFirestore;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ReportMissingScreen extends StatefulWidget {
//   const ReportMissingScreen({super.key});

//   @override
//   State<ReportMissingScreen> createState() => _ReportMissingScreenState();
// }

// class _ReportMissingScreenState extends State<ReportMissingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//   String? _selectedGender;
//   File? _selectedImage;

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   Future<String?> uploadImageToFirebase(File imageFile) async {
//     try {
//       // 1. Create a file path with timestamp
//       String fileName =
//           'missing_children/${DateTime.now().millisecondsSinceEpoch}.jpg';

//       // 2. Upload file to Firebase Storage
//       final ref = FirebaseStorage.instance.ref().child(fileName);
//       final uploadTask = await ref.putFile(imageFile);

//       // 3. After upload, get URL
//       final downloadUrl = await ref.getDownloadURL();

//       return downloadUrl;
//     } catch (e) {
//       print('Image upload error: $e');
//       return null;
//     }
//   }

//   Future<void> submitReport() async {
//     if (_selectedImage == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please upload an image')),
//       );
//       return;
//     }

//     final imageUrl = await uploadImageToFirebase(_selectedImage!);
//     if (imageUrl == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Image upload failed')),
//       );
//       return;
//     }

//     try {
//       await FirebaseFirestore.instance.collection('missing_children').add({
//         'name': _nameController.text.trim(),
//         'age': int.parse(_ageController.text.trim()),
//         'gender': _selectedGender,
//         'location': _locationController.text.trim(),
//         'contact_number': _contactController.text.trim(),
//         'image_url': imageUrl,
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Report submitted successfully!')),
//       );

//       _formKey.currentState?.reset();
//       setState(() {
//         _selectedImage = null;
//         _selectedGender = null;
//       });
//     } catch (e) {
//       print('Error submitting report: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   // Common Input Decoration
//   InputDecoration inputDecoration(String hint, IconData icon) {
//     return InputDecoration(
//       hintText: hint,
//       prefixIcon: Icon(icon, color: const Color.fromARGB(255, 23, 7, 167)),
//       filled: true,
//       fillColor: const Color.fromARGB(255, 247, 241, 241),
//       hintStyle: const TextStyle(color: AppColors.black),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//             color: Color.fromARGB(255, 205, 194, 194)), // default border color
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(
//             color: Color.fromARGB(255, 150, 205, 209)), // non-focused border
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     );
//   }

//   // Consistent Button Style
//   Widget customButton(String text, void Function()? onPressed) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColors.primary,
//           foregroundColor: AppColors.background,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Text(text, style: const TextStyle(fontSize: 16)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColors.primary,
//         title: Text(
//           "Report Missing Child",
//           style: TextStyle(
//               color: AppColors.background,
//               fontSize: 20,
//               fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back,
//                 color: const Color.fromARGB(255, 37, 8, 165))),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Full Name
//               const Text('Full Name', style: TextStyle(color: AppColors.black)),
//               const SizedBox(height: 6),
//               TextFormField(
//                 cursorColor: AppColors.primary,
//                 controller: _nameController,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Name is required' : null,
//                 decoration: inputDecoration(
//                   'Enter child\'s full name',
//                   Icons.person,
//                 ),
//                 style:
//                     const TextStyle(color: Color.fromRGBO(19, 19, 255, 0.216)),
//               ),
//               const SizedBox(height: 20),

//               // Age
//               const Text('Age', style: TextStyle(color: AppColors.black)),
//               const SizedBox(height: 6),
//               TextFormField(
//                 cursorColor: AppColors.primary,
//                 controller: _ageController,
//                 keyboardType: TextInputType.number,
//                 validator: (value) =>
//                     value == null || value.isEmpty ? 'Age is required' : null,
//                 decoration: inputDecoration('Enter age', Icons.cake),
//                 style: const TextStyle(color: AppColors.background),
//               ),
//               const SizedBox(height: 20),

//               // Gender
//               const Text('Gender', style: TextStyle(color: AppColors.black)),
//               const SizedBox(height: 6),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 validator: (value) =>
//                     value == null ? 'Please select gender' : null,
//                 decoration: inputDecoration('Select gender', Icons.transgender),
//                 dropdownColor: const Color.fromARGB(255, 37, 19, 201),
//                 iconEnabledColor: const Color.fromARGB(255, 46, 12, 168),
//                 style: const TextStyle(color: Colors.white),
//                 items: ['Male', 'Female', 'Other']
//                     .map((gender) => DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender,
//                               style: const TextStyle(color: Colors.white)),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedGender = value;
//                   });
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Last Seen Location
//               const Text('Last Seen Location',
//                   style: TextStyle(color: AppColors.black)),
//               const SizedBox(height: 6),
//               TextFormField(
//                 cursorColor: AppColors.primary,
//                 controller: _locationController,
//                 validator: (value) => value == null || value.isEmpty
//                     ? 'Location is required'
//                     : null,
//                 decoration: inputDecoration(
//                     'Type location or describe area', Icons.location_on),
//                 style: const TextStyle(color: Color.fromARGB(255, 12, 38, 169)),
//               ),
//               // const SizedBox(height: 10),
//               // Container(
//               //   height: 150,
//               //   width: double.infinity,
//               //   decoration: BoxDecoration(
//               //     color: Colors.blueGrey.shade800,
//               //     borderRadius: BorderRadius.circular(10),
//               //   ),
//               //   alignment: Alignment.center,
//               //   child: const Text(
//               //     'Google Map Placeholder',
//               //     style: TextStyle(color: Colors.white60),
//               //   ),
//               // ),
//               const SizedBox(height: 20),

//               // Upload Image
//               const Text('Upload Image',
//                   style: TextStyle(color: AppColors.black)),
//               const SizedBox(height: 6),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColors.light,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   alignment: Alignment.center,
//                   child: _selectedImage == null
//                       ? const Icon(Icons.add_a_photo,
//                           size: 40, color: Colors.white60)
//                       : ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.file(
//                             _selectedImage!,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ),
//                         ),
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Contact Number
//               const Text('Contact Number',
//                   style: TextStyle(color: AppColors.black)),
//               const SizedBox(height: 6),
//               TextFormField(
//                 cursorColor: AppColors.primary,
//                 controller: _contactController,
//                 keyboardType: TextInputType.phone,
//                 decoration:
//                     inputDecoration('Enter your contact number', Icons.phone),
//                 validator: (value) => value == null || value.isEmpty
//                     ? 'Contact number is required'
//                     : null,
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'For quick response, please share your WhatsApp number if possible.',
//                 style: TextStyle(color: Colors.white54, fontSize: 12),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 30),

//               // Submit Button
//               customButton('Submit Report', () {
//                 // if (_formKey.currentState!.validate()) {
//                 //   ScaffoldMessenger.of(context).showSnackBar(
//                 //     const SnackBar(content: Text('Report submitted!')),
//                 //   );
//                 //   // Submit logic can go here
//                 // }
//                 if (_formKey.currentState!.validate()) {
//                   submitReport(); // 🚀 Call submitReport function
//                 }
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:child_missing_app1/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportMissingScreen extends StatefulWidget {
  const ReportMissingScreen({super.key});

  @override
  State<ReportMissingScreen> createState() => _ReportMissingScreenState();
}

class _ReportMissingScreenState extends State<ReportMissingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  String? _selectedGender;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName =
          'missing_children/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Image upload error: $e');
      return null;
    }
  }

  Future<void> submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload an image')),
      );
      return;
    }

    final imageUrl = await uploadImageToFirebase(_selectedImage!);
    if (imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image upload failed')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('missing_children').add({
        'name': _nameController.text.trim(),
        'age': int.parse(_ageController.text.trim()),
        'gender': _selectedGender,
        'location': _locationController.text.trim(),
        'contact_number': _contactController.text.trim(),
        'image_url': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully!')),
      );

      _formKey.currentState?.reset();
      setState(() {
        _selectedImage = null;
        _selectedGender = null;
      });
    } catch (e) {
      print('Error submitting report: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color.fromARGB(255, 23, 7, 167)),
      filled: true,
      fillColor: const Color.fromARGB(255, 247, 241, 241),
      hintStyle: const TextStyle(color: AppColors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color.fromARGB(255, 150, 205, 209)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget customButton(String text, void Function()? onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.background,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text(
          "Report Missing Child",
          style: TextStyle(
              color: AppColors.background,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 37, 8, 165)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Full Name', style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nameController,
                decoration:
                    inputDecoration('Enter child\'s full name', Icons.person),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Age', style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration('Enter age', Icons.cake),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Age is required' : null,
              ),
              const SizedBox(height: 20),
              const Text('Gender', style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: inputDecoration('Select gender', Icons.transgender),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                validator: (value) =>
                    value == null ? 'Please select gender' : null,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text('Last Seen Location',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _locationController,
                decoration: inputDecoration(
                    'Type location or describe area', Icons.location_on),
                validator: (value) => value == null || value.isEmpty
                    ? 'Location is required'
                    : null,
              ),
              const SizedBox(height: 20),
              const Text('Upload Image',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: _selectedImage == null
                      ? const Icon(Icons.add_a_photo,
                          size: 40, color: Colors.white60)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('Contact Number',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration:
                    inputDecoration('Enter your contact number', Icons.phone),
                validator: (value) => value == null || value.isEmpty
                    ? 'Contact number is required'
                    : null,
              ),
              const SizedBox(height: 30),
              customButton('Submit Report', submitReport),
            ],
          ),
        ),
      ),
    );
  }
}
