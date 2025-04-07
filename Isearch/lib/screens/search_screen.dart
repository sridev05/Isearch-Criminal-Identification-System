import 'package:flutter/material.dart';
import '../widgets/custom_nav_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> searchHistory = [
      {"date": "07/04/2025", "name": "Edward Lee Swift ", "image": "D:/projects/Isearch/assets/images/user1.jpg"},
      {"date": "06/04/2025", "name": "Jaffer sadiq", "image": "assets/images/user2.jpg"},
      {"date": "29/03/2025", "name": "Jennifer Lopez", "image": "assets/images/user3.jpg"},
      {"date": "29/03/2025", "name": "James Bond", "image": "assets/images/user4.jpg"},
      {"date": "26/03/2025", "name": "Jackie Chan", "image": "assets/images/user5.jpg"},
      {"date": "22/03/2025", "name": "Jesse Pinkman", "image": "assets/images/user6.jpg"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Searches", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: const [
          Icon(Icons.keyboard_arrow_down, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Completed Searches",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  final item = searchHistory[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(item["image"]!),
                      radius: 25,
                    ),
                    title: Text(item["date"]!, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(item["name"]!, style: const TextStyle(color: Colors.grey)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
      backgroundColor: Colors.black, // Dark theme background
    );
  }
}
