import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/custom_nav_bar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  Uint8List? _imageBytes; // For Web compatibility
  Map<String, String>? _criminalDetails; // Holds criminal info

  // Function to pick an image
  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if (kIsWeb) {
        Uint8List bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _selectedImage = image;
          _criminalDetails = null; // Reset details when new image is selected
        });
      } else {
        setState(() {
          _selectedImage = image;
          _criminalDetails = null;
        });
      }
    }
  }

  // Simulated function to fetch criminal details
  void searchCriminal() {
    // Here, you can call your API to fetch details from the database
    setState(() {
      _criminalDetails = {
        'Name': 'John Doe',
        'Case Number': 'CR-20245',
        'Crime': 'Bank Robbery',
        'Status': 'Wanted',
        'Last Seen': 'New York City',
        'Description': 'A suspect in multiple bank heists. Considered armed and dangerous.',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Isearch',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search criminal records...',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Upload Photo'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Display Selected Image
                if (_selectedImage != null) ...[
                  const Text(
                    'Selected Image:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: kIsWeb
                        ? Image.memory(_imageBytes!, height: 200)
                        : Image.file(File(_selectedImage!.path), height: 200),
                  ),
                  const SizedBox(height: 20),

                  // Search Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: searchCriminal, // Call the function
                      icon: const Icon(Icons.search),
                      label: const Text('Search Criminal'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 30),

                // Display Criminal Details
                if (_criminalDetails != null) ...[
                  const Text(
                    'Criminal Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _criminalDetails!.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '${entry.key}: ${entry.value}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 30),
                const Text(
                  'Recent Activities',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildActivityCard(
                      'New Case Added',
                      'Criminal Case #8 was added to the database',
                      '2 hours ago',
                      Icons.add_circle,
                      Colors.green,
                    ),
                    _buildActivityCard(
                      'Photo Uploaded',
                      'New evidence photo added to Case #5',
                      '4 hours ago',
                      Icons.photo,
                      Colors.blue,
                    ),
                    _buildActivityCard(
                      'Case Updated',
                      'Status changed for Criminal Case #3',
                      '1 day ago',
                      Icons.update,
                      Colors.orange,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 0),
    );
  }

  Widget _buildActivityCard(String title, String description, String time, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(description),
        trailing: Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ),
    );
  }
}
