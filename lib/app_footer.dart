import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Opacity(
        opacity: 0.8,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double iconSize = constraints.maxWidth / 8;
              double fontSize = constraints.maxWidth / 32;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final Uri _emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'pfarre.silz@dibk.at',
                          );

                          try {
                            if (await canLaunchUrlString(_emailLaunchUri.toString())) {
                              await launchUrlString(_emailLaunchUri.toString());
                            } else {
                              throw Exception("Could not launch URL");
                            }
                          } catch (e) {
                            print("Error launching URL: $e");
                          }
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.email,
                              size: iconSize,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'pfarre.silz@dibk.at',
                              style: GoogleFonts.lato(
                                fontSize: fontSize,
                                color: Colors.grey[600],
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: iconSize,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '@church_app',
                            style: GoogleFonts.lato(
                              fontSize: fontSize,
                              color: Colors.grey[600],
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            // Add your action here
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.phone,
                                size: iconSize,
                                color: Colors.green,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '+43(5263)6210',
                                style: GoogleFonts.lato(
                                  fontSize: fontSize,
                                  color: Colors.grey[600],
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            // Add your action here
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: iconSize,
                                color: Colors.orange,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Schulstraße 2 | 6424 Silz',
                                style: GoogleFonts.lato(
                                  fontSize: fontSize,
                                  color: Colors.grey[600],
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
