import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnbook/core/utils/responsive.dart';
import 'package:video_player/video_player.dart';

class FeedVideo extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;

  const FeedVideo({
    super.key,
    required this.videoUrl,
    required this.thumbnailUrl,
  });

  @override
  State<FeedVideo> createState() => _FeedVideoState();
}

class _FeedVideoState extends State<FeedVideo> {
  VideoPlayerController? _controller;
  bool _isInitializing = false;

  Future<void> _initializeVideo() async {
    if (_controller != null || _isInitializing) return;

    _isInitializing = true;

    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      controller.addListener((){
        if(mounted){
          setState(() {});
        }
      });

      setState(() {
        _controller = controller;
      });
    } catch (e) {
      debugPrint("Video init error: $e");
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> _togglePlay() async {
    try {
      if (_controller == null) {
        await _initializeVideo();
      }

      if (!(_controller?.value.isInitialized ?? false)) return;

      if (_controller!.value.isPlaying) {
        await _controller!.pause();
      } else {
        await _controller!.play();
      }

      if (!mounted) return;

      setState(() {});
    } catch (e) {
      debugPrint("Video play error: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller?.value.isInitialized ?? false) {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller!),
            GestureDetector(
              onTap: _togglePlay,
              child: Icon(
                _controller?.value.isPlaying ?? false 
                    ? CupertinoIcons.pause_circle
                    : CupertinoIcons.play_circle_fill,
                size: 60,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            widget.thumbnailUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Container(
                color: Colors.grey,
                width: double.infinity,
                height: context.width(150),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
          const Icon(Icons.play_circle, size: 60, color: Colors.white),
        ],
      ),
    );
  }
}
