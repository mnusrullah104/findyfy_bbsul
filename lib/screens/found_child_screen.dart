import 'dart:io';
import 'package:child_missing_app1/theme/colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class FoundChildScreen extends StatefulWidget {
  const FoundChildScreen({super.key});

  @override
  State<FoundChildScreen> createState() => _FoundChildScreenState();
}

class _FoundChildScreenState extends State<FoundChildScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedImage;
  LatLng? _location;
  String? _gender = 'Boy';

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  Future<void> _getLocation() async {
    var permission = await Permission.location.request();
    if (permission.isGranted) {
      Position pos = await Geolocator.getCurrentPosition();
      setState(() {
        _location = LatLng(pos.latitude, pos.longitude);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "Found Child Detail",
          style: TextStyle(
              color: AppColors.background,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upload Image
              const Text('Upload Image (Mandatory)',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  alignment: Alignment.center,
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, size: 40),
                            SizedBox(height: 8),
                            Text('Tap to capture image'),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Age Input
              const Text('Approximate Age',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter estimated age';
                  }
                  return null;
                },
                decoration: inputDecoration(
                  hint: 'Enter estimated age',
                  icon: Icons.cake,
                ),
              ),
              const SizedBox(height: 20),

              // Location Found
              const Text('Location Where Found',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _getLocation,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  alignment: Alignment.center,
                  child: _location == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on_outlined, size: 40),
                            SizedBox(height: 8),
                            Text('Tap to detect location'),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on,
                                size: 36, color: Colors.teal),
                            const SizedBox(height: 6),
                            Text(
                                'Lat: ${_location!.latitude.toStringAsFixed(5)}'),
                            Text(
                                'Lng: ${_location!.longitude.toStringAsFixed(5)}'),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Address Input
              const Text('Address (Optional)',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _addressController,
                decoration: inputDecoration(
                  hint: 'Enter location address',
                  icon: Icons.location_on,
                ),
              ),
              const SizedBox(height: 20),

              // Gender Selection
              const Text('Gender', style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Boy',
                        groupValue: _gender,
                        activeColor: AppColors.primary,
                        onChanged: (String? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      const Text('Boy',
                          style: TextStyle(color: AppColors.black)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Girl',
                        groupValue: _gender,
                        activeColor: AppColors.primary,
                        onChanged: (String? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      const Text('Girl',
                          style: TextStyle(color: AppColors.black)),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Other',
                        groupValue: _gender,
                        activeColor: AppColors.primary,
                        onChanged: (String? value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      const Text('Other',
                          style: TextStyle(color: AppColors.black)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Contact Information
              const Text('Contact Number (WhatsApp)',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.phone,
                decoration: inputDecoration(
                  hint: 'Enter contact number',
                  icon: Icons.phone,
                ),
              ),
              const SizedBox(height: 20),

              // Additional Description (Optional)
              const Text('Additional Description (Optional)',
                  style: TextStyle(color: AppColors.black)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: inputDecoration(
                  hint: 'Enter clothing, behavior, or other details',
                  icon: Icons.description,
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _selectedImage != null) {
                      final age = _ageController.text.trim();
                      final address = _addressController.text.trim();
                      final contact = _contactController.text.trim();
                      final description = _descriptionController.text.trim();
                      final gender = _gender;
                      final lat = _location?.latitude ?? 'Unknown';
                      final lng = _location?.longitude ?? 'Unknown';

                      // TODO: Handle form submission (e.g., send to Firebase)

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Report Submitted!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please complete required fields")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, // Light blue
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Submit Report',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.background)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration({required String hint, IconData? icon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, color: const Color.fromARGB(255, 39, 13, 184))
          : null,
      fillColor: const Color.fromARGB(255, 247, 241, 241),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
