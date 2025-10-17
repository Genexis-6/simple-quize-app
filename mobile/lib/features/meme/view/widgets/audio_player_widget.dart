import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mobile/features/meme/provider/audio_play_provider.dart';
import 'package:provider/provider.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioPlayProvider>().init(player: _player);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayProvider>(
      builder: (context, state, _) {
        return IconButton(
          icon: Icon(
            state.getStatus ? Icons.pause : Icons.play_arrow,
            color: state.getStatus ? Colors.red : Colors.green,
            size: 40,
          ),
          onPressed: () => state.play(url: widget.audioUrl),
        );
      },
    );
  }
}
