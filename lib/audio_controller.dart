import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isPlaying = false;

  static Future<void> playBackgroundMusic() async {
    if (!_isPlaying) {
      _isPlaying = true;
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('audios/audio_fundo_final.mp3'));
    }
  }

  static Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
  }
}
