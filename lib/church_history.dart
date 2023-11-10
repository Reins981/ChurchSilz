import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_contents.dart';

class ChurchHistoryPage extends StatelessWidget {

  const ChurchHistoryPage({super.key, required this.selectedLanguage});

  final String selectedLanguage;

  @override
  Widget build(BuildContext context) {

    final String churchHistoryMessageHeader = selectedLanguage == "Deutsch" ?
    getTextContentGerman("churchHistoryMessageHeader"): getTextContentEnglish("churchHistoryMessageHeader");
    final String churchHistoryMessageTitle = selectedLanguage == "Deutsch" ?
    getTextContentGerman("churchHistoryMessageTitle"): getTextContentEnglish("churchHistoryMessageTitle");
    final String churchHistoryMessage = selectedLanguage == "Deutsch" ?
    getTextContentGerman("churchHistoryMessage"): getTextContentEnglish("churchHistoryMessage");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(churchHistoryMessageHeader, style: GoogleFonts.lato(fontSize: 20, letterSpacing: 1.0)),
          centerTitle: true,
          backgroundColor: const Color(0xFFD2B48C),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                churchHistoryMessageTitle,
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),
              Text(churchHistoryMessage,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 16),
              Text(churchHistoryMessage,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  letterSpacing: 1.0,
                ),
              ),
              // Continue adding more text as needed
            ],
          ),
        ),
      ),
    );
  }
}
