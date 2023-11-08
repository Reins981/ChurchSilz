import 'package:flutter/material.dart';
import 'package:church_silz/virtual_church.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DashboardOption(
                title: 'Church History',
                icon: Icons.history, // Replace with your custom icon
                onTap: () {
                  // Navigate to Church History screen
                  // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ChurchHistoryScreen()));
                },
              ),
              DashboardOption(
                title: 'Virtual Church Tour',
                icon: Icons.location_pin, // Replace with your custom icon
                onTap: () {
                  // Navigate to Virtual Church Tour screen
                  // You can use Navigator to push a new screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VirtualChurchScreen()));
                },
              ),
              DashboardOption(
                title: 'Donation Selection',
                icon: Icons.monetization_on, // Replace with your custom icon
                onTap: () {
                  // Navigate to Donation Selection screen
                  // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => DonationSelectionScreen()));
                },
              ),
              DashboardOption(
                title: 'Actual News Selection',
                icon: Icons.article, // Replace with your custom icon
                onTap: () {
                  // Navigate to Actual News Selection screen
                  // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NewsSelectionScreen()));
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}

class DashboardOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const DashboardOption({super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 64,
                color: const Color(0xFFD2B48C), // Customize icon color
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}
