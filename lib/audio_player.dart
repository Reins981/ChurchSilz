import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPlayerControls extends StatefulWidget {
  final AssetsAudioPlayer player;
  final String audioUrl;

  AudioPlayerControls({required this.player, required this.audioUrl});

  @override
  _AudioPlayerControlsState createState() => _AudioPlayerControlsState(player: player, audioUrl: audioUrl);
}


class _AudioPlayerControlsState extends State<AudioPlayerControls> {

  final AssetsAudioPlayer player;
  final String audioUrl;
  double _currentVolume = 0.5; // Initialize with a default value
  Duration _currentPosition = Duration.zero;

  _AudioPlayerControlsState({required this.player, required this.audioUrl});

  double _calculateSliderPosition() {
    final totalDuration = _getTotalDuration();
    final currentPosition = _getCurrentPosition();

    if (totalDuration != Duration.zero && currentPosition != Duration.zero) {
      return currentPosition.inMilliseconds / totalDuration.inMilliseconds;
    }
    return 0.0;
  }

  Duration _calculateDuration(double sliderValue) {
    final totalDuration = _getTotalDuration();
    if (totalDuration != Duration.zero) {
      return Duration(milliseconds: (sliderValue * totalDuration.inMilliseconds).round());
    }
    return Duration.zero;
  }

  Duration _getTotalDuration() {
    final current = player.current.valueOrNull;
    if (current != null) {
      return current.audio.duration;
    }
    return Duration.zero;
  }

  Duration _getCurrentPosition() {
    final currentPosition = player.currentPosition.valueOrNull;
    if (currentPosition != null) {
      return currentPosition;
    }
    return Duration.zero;
  }

  double _getCurrentVolume() {
    final currentVolume = player.volume.valueOrNull;
    if (currentVolume != null) {
      return currentVolume;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16), // Add some spacing at the top

        Row (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.volume_down),
              onPressed: () {
                setState(() {
                  final newVolume = _currentVolume - 0.1;
                  if (newVolume >= 0.0) {
                    player.setVolume(newVolume);
                    _currentVolume = newVolume;
                  }
                });
              },
            ),
            Slider(
              value: _currentVolume,
              onChanged: (value) {
                setState(() {
                  player.setVolume(value);
                  _currentVolume = value;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {
                setState(() {
                  final newVolume = _currentVolume + 0.1;
                  if (newVolume <= 1.0) {
                    player.setVolume(newVolume);
                    _currentVolume = newVolume;
                  }
                });
              },
            ),
          ],
        ),

        Slider(
          value: _calculateSliderPosition(),
          onChanged: (value) {
            setState(() {
              final newPosition = _calculateDuration(value);
              player.seek(newPosition);
              _currentPosition = newPosition;

              final totalDuration = _getTotalDuration();
              if (_currentPosition >= totalDuration) {
                _currentPosition = Duration.zero;
              }
            });
          },
        ),

        const SizedBox(height: 8), // Add some spacing between the sliders and buttons

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                player.play();
              },
            ),
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () {
                player.pause();
              },
            ),
          ],
        ),
      ],
    );
  }
}