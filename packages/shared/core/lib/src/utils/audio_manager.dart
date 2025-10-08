import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Utility class for managing audio in the app
class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  final AudioPlayer _player = AudioPlayer();
  bool _soundEnabled = true;
  double _volume = 0.7;
  bool _isInitialized = false;

  /// Initialize the audio manager
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _player.setVolume(_volume);
      await _player.setReleaseMode(ReleaseMode.stop);
      _isInitialized = true;
      debugPrint('AudioManager initialized');
    } catch (e) {
      debugPrint('AudioManager initialization failed: $e');
    }
  }

  /// Enable or disable sound
  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  /// Check if sound is enabled
  bool get isSoundEnabled => _soundEnabled;

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    _volume = volume.clamp(0.0, 1.0);
    await _player.setVolume(_volume);
  }

  /// Get current volume
  double get volume => _volume;

  /// Play a sound effect
  Future<void> playSound(AppSound sound) async {
    log('enabled_sound: $_soundEnabled');
    if (!_soundEnabled || !_isInitialized) return;

    try {
      await _player.play(AssetSource(sound.path));
    } catch (e) {
      // SystemSound.play(SystemSoundType.click);
      debugPrint('Error playing sound ${sound.path}: $e');
    }
  }

  /// Convenience methods
  Future<void> playCorrect() => playSound(AppSound.correct);
  Future<void> playIncorrect() => playSound(AppSound.incorrect);
  Future<void> playPointsEarned() => playSound(AppSound.pointsEarned);
  Future<void> playPointsSpent() => playSound(AppSound.pointsSpent);
  Future<void> playLevelUp() => playSound(AppSound.levelUp);
  Future<void> playAchievement() => playSound(AppSound.achievement);
  Future<void> playChaosEvent() => playSound(AppSound.chaosEvent);
  Future<void> playButtonClick() => playSound(AppSound.buttonClick);
  Future<void> playNoteCreated() => playSound(AppSound.noteCreated);
  Future<void> playError() => playSound(AppSound.error);
  Future<void> playSuccess() => playSound(AppSound.correct);

  /// Dispose resources
  Future<void> dispose() async {
    await _player.dispose();
    _isInitialized = false;
  }
}

// Enum for all app sounds
enum AppSound {
  correct('sounds/success.mp3'),
  incorrect('sounds/fail.mp3'),
  pointsEarned('sounds/coin.mp3'),
  pointsSpent('sounds/whoosh.mp3'),
  levelUp('sounds/pick_up.mp3'),
  achievement('sounds/success.mp3'),
  chaosEvent('sounds/alert.mp3'),
  buttonClick('sounds/button_click.mp3'),
  noteCreated('sounds/notification.mp3'),
  error('sounds/error.mp3');

  final String path;
  const AppSound(this.path);
}
