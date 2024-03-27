import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerViewModel extends ChangeNotifier {
  VideoPlayerController? _controller;

  VideoPlayerController? get controller => _controller;

  void initializeController(String videoUrl) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        notifyListeners();
      });
  }

  void disposeController() {
    _controller?.dispose();
    _controller = null;
    notifyListeners();
  }
}
