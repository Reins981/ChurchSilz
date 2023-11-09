import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:church_silz/virtual_church.dart';
import 'package:church_silz/church_history.dart';
import 'package:church_silz/news_section.dart';
import 'package:church_silz/donation.dart';

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
      body: ListView(
        children: [
          SizedBox(
            height: 300, // Adjust the height for the map
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD2B48C),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Interactive Map',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 220, // Adjust the map height
                    child: FlutterMap(
                      options: const MapOptions(
                        center: LatLng(47.26534, 10.92777),
                        zoom: 15.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        const MarkerLayer(
                          markers: [
                            Marker(
                              alignment: Alignment.center,
                              width: 60.0,
                              height: 60.0,
                              point: LatLng(47.26534, 10.92777),
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 400, // Adjust the height for the map
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DashboardOption(
                    title: 'Virtual Church',
                    icon: Icons.location_pin,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VirtualChurchScreen()));
                    },
                  ),
                  DashboardOption(
                    title: 'Church History',
                    icon: Icons.history,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChurchHistoryPage()));
                    },
                  ),
                  DashboardOption(
                    title: 'Actual News',
                    icon: Icons.article,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsSection()));
                    },
                  ),
                  DashboardOption(
                    title: 'Donation',
                    icon: Icons.monetization_on,
                    onTap: () {
                      // Navigate to Donation Selection screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DonationPage()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;

  const DashboardOption({
    super.key,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Icon(
              icon,
              size: 64,
              color: const Color(0xFFD2B48C),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center-align the text
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

