import 'package:flutter/material.dart';
import 'carousel_slider.dart';
import 'church_map.dart';
import 'church_highlight.dart';
import 'package:google_fonts/google_fonts.dart';
import 'text_contents.dart';

class VirtualChurchScreen extends StatefulWidget {

  const VirtualChurchScreen({super.key, required this.selectedLanguage});

  final String selectedLanguage;

  @override
  _VirtualChurchScreenState createState() => _VirtualChurchScreenState();
}

class _VirtualChurchScreenState extends State<VirtualChurchScreen> {
  late List<ChurchHighlight> churchHighlights;
  int selectedHighlightIndex = 0;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    churchHighlights = [
      ChurchHighlight(
        id: '1',
        image: 'assets/ornament_frame.png',
        audioUrl: "assets/audio/english/sample.wav",
        positionXPercentage: 0.3,
        positionYPercentage: 0.1,
        selectedLanguage: widget.selectedLanguage,
      ),
      ChurchHighlight(
        id: '2',
        image: 'assets/highlight2.JPG',
        audioUrl: "assets/audio/english/sample.wav",
        positionXPercentage: 0.50,
        positionYPercentage: 0.1,
        selectedLanguage: widget.selectedLanguage,
      ),
    ];
  }

  void updateSelectedHighlightIndex(int index) {
    setState(() {
      selectedHighlightIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final String virtualChurchMessageHeader = widget.selectedLanguage == "Deutsch" ?
    getTextContentGerman("virtualChurchMessageHeader"): getTextContentEnglish("virtualChurchMessageHeader");

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(virtualChurchMessageHeader, style: GoogleFonts.lato(fontSize: 20, letterSpacing: 1.0)),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      body: Column(
        children: [
          VirtualChurchTourSection(churchHighlights: churchHighlights, onHighlightSelected: updateSelectedHighlightIndex, selectedLanguage: widget.selectedLanguage,),
          Expanded(
            child: ChurchGroundView(selectedHighlightIndex: selectedHighlightIndex, churchHighlights: churchHighlights),
          ),
          // Other sections can be added here
        ],
      ),
    );
  }
}
