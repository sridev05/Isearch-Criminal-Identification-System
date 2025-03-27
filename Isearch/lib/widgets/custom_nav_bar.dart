import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/records_screen.dart';
import '../screens/search_screen.dart';
import '../screens/profile_screen.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index != currentIndex) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                switch (index) {
                  case 0:
                    return const HomeScreen();
                  case 1:
                    return const RecordsScreen();
                  case 2:
                    return const SearchScreen();
                  case 3:
                    return const ProfileScreen();
                  default:
                    return const HomeScreen();
                }
              },
            ),
          );
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_drive_file),
          label: 'Records',
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
    );
  }
}