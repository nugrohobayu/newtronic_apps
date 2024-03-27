import 'package:flutter/material.dart';
import 'package:newtronic_apps/components/video_player/video_player_viewmodel.dart';
import 'package:newtronic_apps/utils/size_config.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoPlayerViewModel(),
      child: _VideoPlayerWidget(videoUrl: videoUrl),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const _VideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerViewModel _videoPlayerModel;
  bool isIconVisible = true;

  @override
  void initState() {
    super.initState();

    _videoPlayerModel =
        Provider.of<VideoPlayerViewModel>(context, listen: false);
    _videoPlayerModel.initializeController(widget.videoUrl);
  }

  @override
  void dispose() {
    _videoPlayerModel.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: SizeConfig.height * .31,
            child: _videoPlayerModel.controller != null
                ? VideoPlayer(_videoPlayerModel.controller!)
                : const CircularProgressIndicator(),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  if (_videoPlayerModel.controller!.value.isPlaying) {
                    _videoPlayerModel.controller!.pause();
                  } else {
                    _videoPlayerModel.controller!.play();
                  }
                });
              },
              icon: Icon(
                _videoPlayerModel.controller!.value.isPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
                size: 50,
              )),
        ],
      ),
    );
  }
}
