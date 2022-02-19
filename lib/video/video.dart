// ignore_for_file: sized_box_for_whitespace

import 'package:Fuligo/screens/cancel_tour.dart';
import 'package:Fuligo/screens/keizersgracht.dart';
import 'package:Fuligo/screens/route_screen.dart';
import 'package:Fuligo/utils/font_style.dart';
import 'package:Fuligo/widgets/circleimage.dart';
import 'package:Fuligo/widgets/clear_button.dart';
import 'package:flutter/material.dart';

import 'package:Fuligo/utils/common_colors.dart';
import 'package:Fuligo/widgets/text_header.dart';
import 'package:Fuligo/widgets/custom_button.dart';
import 'package:Fuligo/widgets/image_detail.dart';
import 'package:Fuligo/widgets/subtxt.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:video_player/video_player.dart';
// import 'package:audioplayers/audioplayers.dart';

// import 'package:Fuligo/screens/tours.dart';

class VideoScreen extends StatefulWidget {
  Map mediadata;
  VideoScreen({Key? key, required this.mediadata}) : super(key: key);

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool startedPlaying = false;
  String totalTimeString = "";
  String currentTimeString = "";

  void initState() {
    super.initState();
    try {
      if (widget.mediadata["video"].length > 0) {
        _controller =
            VideoPlayerController.network((widget.mediadata["video"]));
        _initializeVideoPlayerFuture = _controller.initialize();

        _controller.addListener(() {
          setState(() {});
        });
        _controller.setLooping(true);
        _controller.initialize().then((_) => setState(() {}));
      } else if (widget.mediadata["audio"].length > 0) {
        // AudioPlayer audioPlayer = AudioPlayer();
      }
    } catch (e) {
      SmartDialog.showToast("No data");
    }

    // _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    Map mediadata = widget.mediadata;
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
                            child: _ControlsOverlay(
                                controller: _controller, infodata: mediadata)),
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
                              RatingBar.builder(
                                initialRating: mediadata["rating"]!,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20.0,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.favorite,
                                  color: whiteColor,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
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
  Map infodata;
  _ControlsOverlay({Key? key, required this.controller, required this.infodata})
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
    Map infodata = this.infodata;
    print("infodata");
    print(infodata);
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
                                    builder: (context) =>
                                        Keizersgracht(infodata: infodata),
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
                            ),
                    ),
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
