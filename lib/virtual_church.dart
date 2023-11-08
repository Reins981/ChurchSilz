import 'package:flutter/material.dart';
import 'carousel_slider.dart';
import 'church_map.dart';
import 'church_highlight.dart';
import 'package:latlong2/latlong.dart'; // For LatLng

class VirtualChurchScreen extends StatefulWidget {
  @override
  _VirtualChurchScreenState createState() => _VirtualChurchScreenState();
}

class _VirtualChurchScreenState extends State<VirtualChurchScreen> {
  final List<ChurchHighlight> churchHighlights = [
    ChurchHighlight(
        id: '1',
        image: 'assets/ornament_frame.png',
        title: 'Titel1',
        description: 'Die den Aposteln Petrus und Paulus geweihte Pfarrkirche von Silz wurde in den Jahren 1846 bis 1848 an Stelle eines älteren Baus unter der Leitung des Baumeisters Benedikt Perwög erbaut. Ursprünglich hätte der vom Architekten Alois Haas für 1400 Personen ausgelegte Bau noch um einiges größer werden sollen, als er dann tatsächlich zur Ausführung gelangte, aber für dieses Projekt konnte von der Regierung keine Genehmigung erlangt werden. Obwohl sich die überarbeiteten Haas´schen Pläne in technischer Beziehung als zweckmäßig und ausführbar erwiesen, hatten die Initiatoren des Kirchenneubaus, allen voran Pfarrer Peter Span, in der eigenen Gemeinde mit großem Widerständen zu kämpfen. Es kam dabei immer wieder zu unschönen Auseinandersetzungen zwischen Befürwortern und Gegnern des Kirchenneubaus, die in zahlreichen Beschwerdeschriften an das Gubernium gipfelten. Die Regierung setzte diesem Streit schließlich mit dem Dekret vom 26. September 1845 ein abruptes Ende, indem sie die Anordnung traf, den Bau sogleich, ohne die weiteren Einwendungen der opponierenden Parteien zu beachten, auszuführen. Noch am Tag, als dieses Dekret ausgefertigt wurde, wurde mit dem Abriss der alten Totenkapelle begonnen. Nach dem Abbruch der alten Kirche konnte endlich mit dem Neubau begonnen werden. Schon ein halbes Jahr nach der Grundsteinlegung am 2. Juli 1846 war der Rohbau des neuen Gotteshauses erstellt und der Turm bis zur Höhe des Kirchendachs aufgeführt. Zu Allerheiligen 1847 war dann auch der Innenausbau so weit fortgeschritten, dass die Pfarrgemeinde in die Kirche einziehen konnte. Am 14. November 1847 wurde sie vom Abt des Stiftes Stams geweiht. ',
        audioUrl: "assets/audio/english/sample.wav",
        positionXPercentage: 0.3,
        positionYPercentage: 0.1,
    ),
    ChurchHighlight(
      id: '2',
      image: 'assets/highlight2.JPG',
      title: 'Titel2',
      description: 'Description for Highlight 2',
      audioUrl: "assets/audio/english/sample.wav",
      positionXPercentage: 0.50,
      positionYPercentage: 0.1,
    ),
  ];

  int selectedHighlightIndex = 0;
  int currentPage = 0;

  void updateSelectedHighlightIndex(int index) {
    setState(() {
      selectedHighlightIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Virtual Church'),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      body: Column(
        children: [
          VirtualChurchTourSection(churchHighlights: churchHighlights, onHighlightSelected: updateSelectedHighlightIndex),
          Expanded(
            child: ChurchGroundView(selectedHighlightIndex: selectedHighlightIndex, churchHighlights: churchHighlights),
          ),
          // Other sections can be added here
        ],
      ),
    );
  }
}
