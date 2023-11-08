import 'package:latlong2/latlong.dart';

class ChurchHighlight {
  final String id;
  final String image;
  final String title;
  final String description;
  String audioUrl;
  final double positionXPercentage;
  final double positionYPercentage;
  final double markerSize; // Add this property for marker size

  ChurchHighlight({required this.id, required this.image, required this.title, required this.description, required this.audioUrl,
    required this.positionXPercentage, required this.positionYPercentage, this.markerSize = 30.0});

}
