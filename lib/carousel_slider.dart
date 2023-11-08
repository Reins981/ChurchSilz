import 'dart:async';

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
      positionXPercentage: 0.3,
      positionYPercentage: 0.2,
  ),
];

class VirtualChurchTourSection extends StatefulWidget {
  final List<ChurchHighlight> churchHighlights;
  final Function(int) onHighlightSelected; // Callback function

  const VirtualChurchTourSection({super.key, required this.churchHighlights,
    required this.onHighlightSelected});

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

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define the position percentages (values between 0.0 and 1.0)
    double xPositionPercentage = 0.3; // 30% from the left
    double yPositionPercentage = 0.15; // 15% from the top

    double xPosition = screenWidth * xPositionPercentage;
    double yPosition = screenHeight * yPositionPercentage;

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
        child: Stack( // Use a Stack to position the AnimatedHandPointer
          children: [
            SingleChildScrollView(
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
            AnimatedHandPointer(
              xPosition: xPosition,
              yPosition: yPosition,
            ),
          ]
        ),
      ),
    );
  }
}

class AnimatedHandPointer extends StatefulWidget {
  final double xPosition;
  final double yPosition;

  AnimatedHandPointer({required this.xPosition, required this.yPosition});

  @override
  _AnimatedHandPointerState createState() => _AnimatedHandPointerState();
}

class _AnimatedHandPointerState extends State<AnimatedHandPointer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // Create a Tween for vertical movement
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 1.0), // Adjust the vertical movement here
    ).animate(_controller);

    // Start the animation
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.xPosition,
      top: widget.yPosition,
      child: SlideTransition(
        position: _animation,
        child: const Column(
          children: [
            Icon(
              Icons.touch_app,
              size: 40,
              color: Colors.brown,
            ),
            Text(
              'Click',
              style: TextStyle(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



