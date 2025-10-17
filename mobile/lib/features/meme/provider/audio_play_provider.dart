import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class AudioPlayProvider extends ChangeNotifier {
  bool _isPlaying = false;

  bool get getStatus => _isPlaying;
  AudioPlayer? _audioPlayer;

  // initialize the player
  void init({required AudioPlayer player}) {
    _audioPlayer = player;

    listenToSongDuration();
    notifyListeners();
  }

  void listenToSongDuration() {
    _audioPlayer!.onPlayerComplete.listen((event) {
      togglePlayer();
      notifyListeners();
    });
  }

  // change playing status
  void togglePlayer() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  // play the song onclick
  Future<void> play({required String url}) async {
    if (_audioPlayer == null) return;

    if (_isPlaying) {
      await _audioPlayer!.pause();
    } else {
      await _audioPlayer!.play(UrlSource(url));
    }
    togglePlayer();
  }
}
