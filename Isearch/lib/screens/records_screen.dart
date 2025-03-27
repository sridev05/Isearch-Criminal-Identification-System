import 'package:flutter/material.dart';
import '../widgets/custom_nav_bar.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  _RecordsScreenState createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  List<Map<String, dynamic>> criminalRecords = [
    {
      'id': 'CR001',
      'name': 'John Doe',
      'case': 'Criminal Case #1',
      'date': '2025-02-18',
      'status': 'Ongoing',
      'details': 'Theft and burglary charges',
      'lastUpdated': '2 hours ago',
      'severity': 'High',
      'location': 'New York, NY'
    },
   
  {
    'id': 'CR001',
    'name': 'John Doe',
    'case': 'Criminal Case #1',
    'date': '2025-02-18',
    'status': 'Ongoing',
    'details': 'Theft and burglary charges',
    'lastUpdated': '2 hours ago',
    'severity': 'High',
    'location': 'New York, NY'
  },
  {
    'id': 'CR002',
    'name': 'Alice Smith',
    'case': 'Fraud Investigation',
    'date': '2024-11-12',
    'status': 'Closed',
    'details': 'Identity theft and credit card fraud',
    'lastUpdated': '1 day ago',
    'severity': 'Medium',
    'location': 'Los Angeles, CA'
  },
  {
    'id': 'CR003',
    'name': 'Michael Johnson',
    'case': 'Assault and Battery',
    'date': '2025-01-05',
    'status': 'Ongoing',
    'details': 'Physical assault in a bar fight',
    'lastUpdated': '5 hours ago',
    'severity': 'High',
    'location': 'Chicago, IL'
  },
  {
    'id': 'CR004',
    'name': 'Emma Brown',
    'case': 'Cybercrime Investigation',
    'date': '2024-12-20',
    'status': 'Pending Trial',
    'details': 'Hacking into corporate servers',
    'lastUpdated': '3 days ago',
    'severity': 'Critical',
    'location': 'San Francisco, CA'
  },
  {
    'id': 'CR005',
    'name': 'David Wilson',
    'case': 'Drug Possession',
    'date': '2023-09-14',
    'status': 'Sentenced',
    'details': 'Illegal drug distribution',
    'lastUpdated': '1 month ago',
    'severity': 'High',
    'location': 'Miami, FL'
  },
  {
    'id': 'CR006',
    'name': 'Sophia Taylor',
    'case': 'Domestic Violence',
    'date': '2024-05-28',
    'status': 'Ongoing',
    'details': 'Allegations of spousal abuse',
    'lastUpdated': '2 weeks ago',
    'severity': 'Medium',
    'location': 'Houston, TX'
  },
  {
    'id': 'CR007',
    'name': 'Daniel Martinez',
    'case': 'Arson Investigation',
    'date': '2023-11-02',
    'status': 'Under Investigation',
    'details': 'Suspected involvement in a building fire',
    'lastUpdated': '4 days ago',
    'severity': 'Critical',
    'location': 'Seattle, WA'
  },
  {
    'id': 'CR008',
    'name': 'Olivia Anderson',
    'case': 'White Collar Crime',
    'date': '2024-06-10',
    'status': 'Closed',
    'details': 'Embezzlement and tax evasion',
    'lastUpdated': '6 months ago',
    'severity': 'Medium',
    'location': 'Boston, MA'
  },
  {
    'id': 'CR009',
    'name': 'James Thomas',
    'case': 'Murder Trial',
    'date': '2025-01-30',
    'status': 'Awaiting Verdict',
    'details': 'Accused of first-degree murder',
    'lastUpdated': '12 hours ago',
    'severity': 'Critical',
    'location': 'Philadelphia, PA'
  },
  {
    'id': 'CR010',
    'name': 'Emily White',
    'case': 'Robbery Case',
    'date': '2024-08-17',
    'status': 'Sentenced',
    'details': 'Armed robbery at a convenience store',
    'lastUpdated': '2 months ago',
    'severity': 'High',
    'location': 'Dallas, TX'
  },

  ];

  void _deleteRecord(int index) {
    setState(() {
      criminalRecords.removeAt(index);
    });
  }

  void _editRecord(int index) {
    TextEditingController nameController =
        TextEditingController(text: criminalRecords[index]['name']);
    TextEditingController statusController =
        TextEditingController(text: criminalRecords[index]['status']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Record"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(labelText: "Status"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  criminalRecords[index]['name'] = nameController.text;
                  criminalRecords[index]['status'] = statusController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _addNewRecord() {
    TextEditingController nameController = TextEditingController();
    TextEditingController caseController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController statusController = TextEditingController();
    TextEditingController detailsController = TextEditingController();
    TextEditingController locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Record"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: caseController,
                  decoration: const InputDecoration(labelText: "Case"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Date"),
                ),
                TextField(
                  controller: statusController,
                  decoration: const InputDecoration(labelText: "Status"),
                ),
                TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(labelText: "Details"),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  criminalRecords.add({
                    'id': 'CR00${criminalRecords.length + 1}',
                    'name': nameController.text,
                    'case': caseController.text,
                    'date': dateController.text,
                    'status': statusController.text,
                    'details': detailsController.text,
                    'location': locationController.text,
                    'lastUpdated': 'Just now',
                    'severity': 'Medium',
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Criminal Records',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: criminalRecords.length,
                  itemBuilder: (context, index) {
                    final record = criminalRecords[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              _getStatusColor(record['status']).withOpacity(0.2),
                          child: Text(record['name'].substring(0, 1)),
                        ),
                        title: Text(record['name']),
                        subtitle: Text(record['case']),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDetailRow('Status', record['status']),
                                _buildDetailRow('Date', record['date']),
                                _buildDetailRow('Location', record['location']),
                                _buildDetailRow('Severity', record['severity']),
                                _buildDetailRow('Details', record['details']),
                                _buildDetailRow(
                                    'Last Updated', record['lastUpdated']),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                      icon: const Icon(Icons.edit),
                                      label: const Text('Edit'),
                                      onPressed: () => _editRecord(index),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton.icon(
                                      icon: const Icon(Icons.delete),
                                      label: const Text('Delete'),
                                      onPressed: () => _deleteRecord(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewRecord,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 1),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return Colors.blue;
      case 'closed':
        return Colors.green;
      case 'under review':
        return Colors.orange;
      case 'pending':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
