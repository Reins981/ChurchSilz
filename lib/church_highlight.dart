import 'text_contents.dart';

class ChurchHighlight {
  final String id;
  final String image;
  String audioUrl;
  final double positionXPercentage;
  final double positionYPercentage;
  final double markerSize; // Add this property for marker size
  final String selectedLanguage;
  final String title;
  final String description;

  ChurchHighlight({
    required this.id,
    required this.image,
    required this.audioUrl,
    required this.positionXPercentage,
    required this.positionYPercentage,
    required this.selectedLanguage,
    this.markerSize = 30.0
  }): title = selectedLanguage == "Deutsch"
        ? getTextContentGerman("churchHighlightTitle_$id")
        : getTextContentEnglish("churchHighlightTitle_$id"),
        description = selectedLanguage == "Deutsch"
        ? getTextContentGerman("churchHighlightDescription_$id")
        : getTextContentEnglish("churchHighlightDescription_$id");
}
