import 'package:flutter/material.dart';
import '../widgets/custom_nav_bar.dart';
import 'settings_screen.dart';
import 'case_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Officer Durai Singam',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Badge No: 12345',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn('Cases', '47'),
                    _buildStatColumn('Active', '12'),
                    _buildStatColumn('Solved', '35'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildActionCard(
                context,
                'Case History',
                'View your case handling history',
                Icons.history,
                Colors.blue,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CaseHistoryScreen()),
                  );
                },
              ),
              _buildActionCard(
                context,
                'Settings',
                'App preferences and notifications',
                Icons.settings,
                Colors.purple,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
              ),
              _buildActionCard(
                context,
                'Help & Support',
                'Get help with using the app',
                Icons.help,
                Colors.orange,
                () {
                  _showHelpSupportDialog(context);
                },
              ),
              _buildActionCard(
                context,
                'Department Info',
                'View department details and contacts',
                Icons.business,
                Colors.green,
                () {
                  _showDepartmentInfoDialog(context);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 3),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap, // Navigate when tapped
      ),
    );
  }

  void _showHelpSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Help & Support'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.question_answer, color: Colors.orange),
                title: Text('FAQs'),
                subtitle: Text('Find answers to common questions.'),
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: Text('Contact Support'),
                subtitle: Text('Email: support@isearchapp.com'),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.green),
                title: Text('Call Support'),
                subtitle: Text('Phone: +91 95782 12140'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDepartmentInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Department Info'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ListTile(
                leading: Icon(Icons.account_balance, color: Colors.green),
                title: Text('Department Name'),
                subtitle: Text('Criminal Investigation Unit'),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.red),
                title: Text('Location'),
                subtitle: Text('123 Police HQ, New York, USA'),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Colors.blue),
                title: Text('Emergency Contact'),
                subtitle: Text('+91 80728 12151'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
