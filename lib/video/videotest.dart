import 'dart:async';

import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/screens/route_screen.dart';
import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool startedPlaying = false;
  String totalTimeString = "";
  String currentTimeString = "";
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/project-flugio.appspot.com/o/poi%2F4-00001-1.mp4?alt=media&token=5fbe73f0-ead3-4735-a093-5dc4d7ca97ee');
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        Container(
                            child: _ControlsOverlay(controller: _controller)),
                        // VideoProgressIndicator(_controller, allowScrubbing: true),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 30),
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                                backgroundColor: Colors.grey,
                                // bufferedColor: Colors.yellow,
                                playedColor: Colors.white),
                          ),
                        ),
                        ClearButton(context),
                        Positioned(
                          top: 65,
                          right: 20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Keizersgrachi",
                                style: font_13_white,
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    color: whiteColor,
                                    size: 20,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  Duration get totalVideoLength {
    return controller.value.duration;
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  String get totalVideoLengthString {
    return _printDuration(totalVideoLength);
  }

  Duration get timeRemaining {
    Duration current = controller.value.position;
    int millis = totalVideoLength.inMilliseconds - current.inMilliseconds;
    return Duration(milliseconds: millis);
  }

  String get timeRemainingString {
    return _printDuration(timeRemaining);
  }

  Duration get timecurrent {
    Duration current = controller.value.position;
    int millis = current.inMilliseconds;
    return Duration(milliseconds: millis);
  }

  String get timeCurrentString {
    return _printDuration(timecurrent);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 60),
                width: MediaQuery.of(context).size.width,
                color: !controller.value.isPlaying
                    ? Colors.black54
                    : Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Keizersgracht(),
                                  ),
                                ),
                              },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 66.0,
                              semanticLabel: 'Route',
                            ),
                          )),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: !controller.value.isPlaying
                            ? GestureDetector(
                                onTap: () {
                                  controller.play();
                                },
                                child: Icon(
                                  Icons.play_circle_outline_outlined,
                                  color: Colors.white,
                                  size: 100.0,
                                  semanticLabel: 'Play',
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.pause();
                                },
                                child: Icon(
                                  Icons.pause_circle_outline,
                                  color: Colors.white,
                                  size: 100.0,
                                  semanticLabel: 'Pause',
                                ),
                              )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                          onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RouteScreen(),
                                  ),
                                ),
                              },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              Icons.power_settings_new_sharp,
                              color: Colors.white,
                              size: 66.0,
                              semanticLabel: 'Route',
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            child: Text(
              timeCurrentString,
              style: TextStyle(color: whiteColor, fontSize: 15),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            child: Text(
              totalVideoLengthString,
              style: TextStyle(color: whiteColor, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
