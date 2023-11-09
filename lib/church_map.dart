import 'package:church_silz/church_highlight.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class ChurchGroundView extends StatefulWidget {
  final List<ChurchHighlight> churchHighlights;
  final int selectedHighlightIndex;

  ChurchGroundView({Key? key, required this.churchHighlights,  required this.selectedHighlightIndex}) : super(key: key);

  @override
  _ChurchGroundViewState createState() => _ChurchGroundViewState();
}

class _ChurchGroundViewState extends State<ChurchGroundView> {

  @override
  Widget build(BuildContext context) {
    // Define the church ground view image
    const churchGroundImageUrl = 'assets/church_ground_view.jpg';

    final markers = <Widget>[];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    for (var i = 0; i < widget.churchHighlights.length; i++) {
      final highlight = widget.churchHighlights[i];
      double xPosition = screenWidth * highlight.positionXPercentage;
      double yPosition = screenHeight * highlight.positionYPercentage;
      final left = xPosition; // Adjust the marker positions as needed
      final top = yPosition;

      // Define the marker size
      final markerSize = (i == widget.selectedHighlightIndex) ? 20.0 : 10.0; // Increase size when selected
      final double imageWidth = (i == widget.selectedHighlightIndex) ? 60: 30;
      final double imageHeight = (i == widget.selectedHighlightIndex) ? 60: 30;

      Widget markerWidget = Positioned(
        left: left,
        top: top,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: markerSize,
                backgroundColor: Colors.red, // Customize marker color
                child: Icon(
                  Icons.location_pin, // Replace with your marker icon
                  size: markerSize * 0.8,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 5), // Adjust the spacing as needed
            ClipOval(
              child: Image.asset(
                highlight.image, // Use the image asset path from ChurchHighlight
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover, // Ensure the image fits within the oval
              ),
            ),
          ],
        ),
      );


      markers.add(markerWidget);
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Image.asset(
            churchGroundImageUrl,
            fit: BoxFit.fill,
            height: double.infinity,
          ),
          ...markers, // Add your markers here
        ],
      ),
    );
  }
}
