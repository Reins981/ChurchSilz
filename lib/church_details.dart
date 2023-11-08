import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:photo_view/photo_view.dart';
import 'package:church_silz/church_highlight.dart';
import 'package:church_silz/audio_player.dart';
import 'package:church_silz/ornament_image.dart';

class ChurchHighlightDetailPage extends StatefulWidget {
  final ChurchHighlight highlight;

  const ChurchHighlightDetailPage({super.key, required this.highlight});

  @override
  _ChurchHighlightDetailPageState createState() => _ChurchHighlightDetailPageState();
}

class _ChurchHighlightDetailPageState extends State<ChurchHighlightDetailPage> {
  late final AssetsAudioPlayer player; // Create a separate player for each highlight
  bool displayAudio = true;
  double minScale = 0.1;
  double maxScale = 0.4;
  bool areControlsVisible = true; // Tracks whether audio player and ornaments should be visible

  @override
  void initState() {
    super.initState();
    // Load and play the local audio file when the widget initializes
    player = AssetsAudioPlayer(); // Initialize the player here
    _loadLocalAudio();
  }

  Future<void> _loadLocalAudio() async {
    await player.open(Audio(widget.highlight.audioUrl),
        autoStart: false, showNotification: true);
  }

  @override
  void dispose() {
    player.dispose(); // Don't forget to release resources when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageHeroTag = 'highlight_${widget.highlight.id}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.highlight.title,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFD2B48C),
      ),
      backgroundColor:  Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: imageHeroTag,
                child: SizedBox(
                  width: 350,
                  height: 350,
                  child: Stack(
                    children: [
                      PhotoView(
                        scaleStateChangedCallback: (scaleState) {
                          if (scaleState == PhotoViewScaleState.initial
                              || scaleState == PhotoViewScaleState.covering) {
                            setState(() {
                              areControlsVisible = true;
                            });
                          } else if (scaleState == PhotoViewScaleState.originalSize) {
                            setState(() {
                              areControlsVisible = false;
                            });
                          }
                        },
                        imageProvider: AssetImage(widget.highlight.image),
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        minScale: minScale,
                        maxScale: maxScale,
                      ),
                      if (areControlsVisible)
                        const Positioned(
                          top: 0, // Adjust the top position as needed
                          right: 0, // Adjust the right position as needed
                          child: Icon(
                            Icons.zoom_in,
                            size: 36,
                            color: Colors.grey,
                          ),
                        ),
                      if (!areControlsVisible)
                        const Positioned(
                          top: 0, // Adjust the top position as needed
                          right: 0, // Adjust the right position as needed
                          child: Icon(
                            Icons.zoom_out,
                            size: 36,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (areControlsVisible) const SizedBox(height: 16),
              if (areControlsVisible)
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildToggleButton(),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: displayAudio
                            ? AudioPlayerControls(player: player, audioUrl: widget.highlight.audioUrl)
                            : _buildTextContent(widget.highlight.description),
                      ),
                    ],
                  ),
                ),
              if (areControlsVisible) const SizedBox(height: 16),
              // Space for the small ornament images
              if (areControlsVisible)
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display small ornament images here
                      OrnamentImage(),
                      OrnamentImage(),
                      OrnamentImage(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              displayAudio = true;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: displayAudio ? const Color(0xFFD2B48C) : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: const Text('Audio'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: () {
            setState(() {
              displayAudio = false;
              player.pause();
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: !displayAudio ? const Color(0xFFD2B48C) : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: const Text('Text'),
        ),
      ],
    );
  }

  Widget _buildTextContent(String description) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        description,
        style: const TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}