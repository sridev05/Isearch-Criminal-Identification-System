import 'package:flutter/material.dart';

class CaseHistoryScreen extends StatefulWidget {
  const CaseHistoryScreen({super.key});

  @override
  _CaseHistoryScreenState createState() => _CaseHistoryScreenState();
}

class _CaseHistoryScreenState extends State<CaseHistoryScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    CaseHistoryScreenContent(),
    Center(child: Text("Search Page", style: TextStyle(color: Colors.white))),
    Center(child: Text("Profile Page", style: TextStyle(color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Case History"),
        backgroundColor: Colors.black,
      ),
      body: _screens[_selectedIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Case History Content (List of Cases)
class CaseHistoryScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: List.generate(5, (index) {
        int caseNumber = 1000 + index;
        return Card(
          color: Colors.grey[900], // Dark theme card
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.2),
              child: const Icon(Icons.file_copy, color: Colors.blue),
            ),
            title: Text("Case #$caseNumber", style: const TextStyle(color: Colors.white)),
            subtitle: const Text("Click to view details", style: TextStyle(color: Colors.grey)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaseDetailsScreen(caseNumber: caseNumber),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

// Case Details Screen
class CaseDetailsScreen extends StatelessWidget {
  final int caseNumber;
  const CaseDetailsScreen({super.key, required this.caseNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Case #$caseNumber Details"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "Details of Case #$caseNumber",
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
