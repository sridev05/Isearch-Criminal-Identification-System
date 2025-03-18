import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingsOption(
            context,
            "Notifications",
            Icons.notifications,
            Colors.blue,
            () {
              _showDialog(context, "Manage Notifications", "Turn on/off app notifications.");
            },
          ),
          _buildSettingsOption(
            context,
            "Privacy & Security",
            Icons.lock,
            Colors.red,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyScreen()),
              );
            },
          ),
          _buildSettingsOption(
            context,
            "Language",
            Icons.language,
            Colors.green,
            () {
              _showDialog(context, "Change Language", "Select your preferred language.");
            },
          ),
          _buildSettingsOption(
            context,
            "Dark Mode",
            Icons.dark_mode,
            Colors.purple,
            () {
              _showDialog(context, "Dark Mode", "Enable or disable dark mode.");
            },
          ),
          _buildSettingsOption(
            context,
            "About",
            Icons.info,
            Colors.orange,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildSettingsOption(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      color: Colors.grey[900], // Dark theme
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
        onTap: onTap,
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

// Placeholder screens for Privacy & About
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy & Security")),
      body: const Center(child: Text("Privacy settings go here")),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: const Center(child: Text("About app details go here")),
    );
  }
}
