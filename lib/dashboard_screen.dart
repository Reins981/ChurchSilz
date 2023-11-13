import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:church_silz/virtual_church.dart';
import 'package:church_silz/church_history.dart';
import 'package:church_silz/news_section.dart';
import 'package:church_silz/donation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:church_silz/prayer.dart';
import 'text_contents.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.selectedLanguage});

  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final String dashboardMessageHeader = selectedLanguage == "Deutsch" ?
    getTextContentGerman("dashboardMessageHeader") : getTextContentEnglish(
        "dashboardMessageHeader");
    final String interactiveMapMessage = selectedLanguage == "Deutsch" ?
    getTextContentGerman("interactiveMapMessage") : getTextContentEnglish(
        "interactiveMapMessage");
    final String virtualChurchDashboard = selectedLanguage == "Deutsch" ?
    getTextContentGerman("virtualChurchDashboard") : getTextContentEnglish(
        "virtualChurchDashboard");
    final String churchHistoryDashboard = selectedLanguage == "Deutsch" ?
    getTextContentGerman("churchHistoryDashboard") : getTextContentEnglish(
        "churchHistoryDashboard");
    final String actualNewsDashboard = selectedLanguage == "Deutsch" ?
    getTextContentGerman("actualNewsDashboard") : getTextContentEnglish(
        "actualNewsDashboard");
    final String donationDashboard = selectedLanguage == "Deutsch" ?
    getTextContentGerman("donationDashboard") : getTextContentEnglish(
        "donationDashboard");
    final String prayerDashboard = selectedLanguage == "Deutsch" ?
    getTextContentGerman("prayerDashboard") : getTextContentEnglish(
        "prayerDashboard");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          dashboardMessageHeader,
          style: GoogleFonts.lato(fontSize: 20, letterSpacing: 1.0),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
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
                      child: Center(
                        child: Text(
                          interactiveMapMessage,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      child: FlutterMap(
                        options: MapOptions(
                          center: LatLng(47.26534, 10.92777),
                          zoom: 15.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 60.0,
                                height: 60.0,
                                point: LatLng(47.26534, 10.92777),
                                builder: (context) => const Icon(
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DashboardOption(
                    title: virtualChurchDashboard,
                    icon: Icons.location_pin,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VirtualChurchScreen(
                                selectedLanguage: selectedLanguage,
                              ),
                        ),
                      );
                    },
                  ),
                  DashboardOption(
                    title: churchHistoryDashboard,
                    icon: Icons.history,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChurchHistoryPage(
                                selectedLanguage: selectedLanguage,
                              ),
                        ),
                      );
                    },
                  ),
                  DashboardOption(
                    title: actualNewsDashboard,
                    icon: Icons.article,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsSection(
                                selectedLanguage: selectedLanguage,
                              ),
                        ),
                      );
                    },
                  ),
                  DashboardOption(
                    title: donationDashboard,
                    icon: Icons.monetization_on,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DonationPage(
                                selectedLanguage: selectedLanguage,
                              ),
                        ),
                      );
                    },
                  ),
                  CustomDashboardOption(
                    title: prayerDashboard,
                    image: Image.asset(
                      'assets/prayer_icon.ico',
                      width: 64,
                      height: 64,
                    ),
                    onTap: () {
                      // Navigate to Donation Selection screen
                      Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => PrayerPage(
                             selectedLanguage: selectedLanguage,
                           ),
                         ),
                       );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
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
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
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

class CustomDashboardOption extends StatelessWidget {
  final String title;
  final Image image;
  final void Function() onTap;

  const CustomDashboardOption({
    super.key,
    required this.title,
    required this.image,
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
            image,
            const SizedBox(height: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
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

