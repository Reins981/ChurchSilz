import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:church_silz/church_highlight.dart';
import 'package:church_silz/church_details.dart';
import 'package:latlong2/latlong.dart'; // For LatLng

final List<ChurchHighlight> churchHighlightsDefault = [
  ChurchHighlight(
      id: '1',
      image: 'assets/highlight1.JPG',
      title: 'Default',
      description: 'Default',
      audioUrl: "assets/audio/english/sample.wav",
      positionX: 100,
      positionY: 150,
  ),
];

class VirtualChurchTourSection extends StatefulWidget {
  final List<ChurchHighlight> churchHighlights;
  final Function(int) onHighlightSelected; // Callback function

  const VirtualChurchTourSection({super.key, required this.churchHighlights, required this.onHighlightSelected});

  @override
  _VirtualChurchTourSectionState createState() =>
      _VirtualChurchTourSectionState();
}

class _VirtualChurchTourSectionState extends State<VirtualChurchTourSection> {
  int selectedHighlightIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      color: const Color(0xFFD2B48C),
      child: Column(
        children: [
          const ListTile(
            title: Center(
              child: Text(
                "Virtuelle Kirchen Tour",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          CarouselSlider.builder(
            itemCount: widget.churchHighlights.length,
            options: CarouselOptions(
              viewportFraction: 0.5,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedHighlightIndex = index; // Update the selected index
                  widget.onHighlightSelected(index); // Notify the parent widget
                });
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final highlight = widget.churchHighlights[index];
              return ChurchHighlightWidget(
                highlight: highlight,
                realIndex: realIndex
              );
            },
          ),
        ],
      ),
    );
  }
}


class ChurchHighlightWidget extends StatelessWidget {
  final ChurchHighlight highlight;
  final int realIndex;

  const ChurchHighlightWidget({super.key, required this.highlight, required this.realIndex});

  @override
  Widget build(BuildContext context) {
    const imageSize = 150.0; // Adjust the size as needed
    final imageHeroTag = 'highlight_$realIndex';

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChurchHighlightDetailPage(highlight: highlight),
          ),
        );
      },
      child: Hero(
        tag: imageHeroTag,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the container and border circular
                  border: Border.all(
                    color: Colors.transparent, // Border color
                    width: 4.0, // Border width
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    highlight.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8), // Adjust the spacing as needed
              Text(
                highlight.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
