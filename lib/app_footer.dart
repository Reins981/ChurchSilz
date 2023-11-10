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
        opacity: 0.8, // Adjust the opacity here
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final Uri _emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'example@example.com',
                      );

                      try {
                        if (await canLaunchUrlString(_emailLaunchUri.toString())) {
                          await launchUrlString(_emailLaunchUri.toString());
                        } else {
                          throw Exception("Could not launch URL");
                        }
                      } catch (e) {
                        // Handle the exception
                        print("Error launching URL: $e");
                      }
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'example@example.com',
                          style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@church_app',
                        style: GoogleFonts.lato(
                          color: Colors.grey[600],
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16), // Add more spacing between the rows
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Placeholder content for the second row
                  GestureDetector(
                    onTap: () {
                      // Add your action here
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '+1234567890',
                          style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add your action here
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '123 Main St',
                          style: GoogleFonts.lato(
                            color: Colors.grey[600],
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
